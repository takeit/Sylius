<?php

/*
 * This file is part of the Sylius package.
 *
 * (c) Paweł Jędrzejewski
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace spec\Sylius\Behat\Context\Setup;

use Behat\Behat\Context\Context;
use PhpSpec\ObjectBehavior;
use Sylius\Component\Addressing\Model\ZoneInterface;
use Sylius\Component\Core\Model\ChannelInterface;
use Sylius\Component\Core\Test\Services\DefaultStoreDataInterface;
use Sylius\Component\Core\Test\Services\SharedStorageInterface;

/**
 * @author Arkadiusz Krakowiak <arkadiusz.krakowiak@lakion.com>
 */
class ChannelContextSpec extends ObjectBehavior
{
    function let(SharedStorageInterface $sharedStorage, DefaultStoreDataInterface $defaultFranceChannelFactory)
    {
        $this->beConstructedWith($sharedStorage, $defaultFranceChannelFactory);
    }

    function it_is_initializable()
    {
        $this->shouldHaveType('Sylius\Behat\Context\Setup\ChannelContext');
    }

    function it_implements_context_interface()
    {
        $this->shouldImplement(Context::class);
    }

    function it_sets_default_channel_in_the_shared_storage(
        SharedStorageInterface $sharedStorage,
        DefaultStoreDataInterface $defaultFranceChannelFactory,
        ChannelInterface $channel,
        ZoneInterface $zone
    ) {
        $defaultData = ['channel' => $channel, 'zone' => $zone];
        $defaultFranceChannelFactory->create()->willReturn($defaultData);
        $sharedStorage->setClipboard($defaultData)->shouldBeCalled();

        $this->thatStoreIsOperatingOnASingleChannel();
    }
}
