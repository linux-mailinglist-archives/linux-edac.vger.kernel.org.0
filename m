Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F25111F64
	for <lists+linux-edac@lfdr.de>; Wed,  4 Dec 2019 00:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfLCXHp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Dec 2019 18:07:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:7337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfLCXHo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Dec 2019 18:07:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 15:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,275,1571727600"; 
   d="scan'208";a="205167708"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2019 15:07:43 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [Bisected] altera_edac crash on a system without ECC
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20191129165739.GA2583@ak-laptop.emea.nsn-net.net>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <3bbd2890-ffcc-39df-8ab6-ecf72d92a006@linux.intel.com>
Date:   Tue, 3 Dec 2019 17:09:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129165739.GA2583@ak-laptop.emea.nsn-net.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Aaro,

On 11/29/19 10:57 AM, Aaro Koskinen wrote:
> Hi,
> 
> I tried booting v5.4 mainline kernel on a stratix10 board with ECC
> disabled, and the altera-edac driver (with only SDRAM enabled) is
> now crashing the system instead of failing the probe with "No ECC/ECC
> disabled".
> 
I apologize for the late reply. I was on vacation.

ECC disabled means the sof/jic that you're loading has ECC disabled, 
correct?

> This seems to have started with commit 08f08bfb7b4c ("EDAC, altera:
> Merge Stratix10 into the Arria10 SDRAM probe routine"). With the change,
> looks like sdram probe no longer uses SMC calls and instead accesses
> the registers directly. The crash looks like this:


I haven't seen this. I'd expect both ECC enabled and disabled to fail 
with the dumps you have below since they'd both need to use the regmap 
functions.

Yes, this does look like it is using the register accesses instead of 
the SMC call. Line 2206 sets the SMC call after determining from the 
if() statement if it is a Stratix10 or Arria10 and from below it seems 
to take the Arria10 path.

> 
> [    4.591371] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> [    4.598816] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-aakoskin+ #8
> [    4.605483] Hardware name: SoCFPGA Stratix 10 test (DT)
> [    4.610683] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [    4.615461] pc : regmap_mmio_read32le+0x24/0x48
> [    4.619969] lr : regmap_mmio_read+0x48/0x70
> [    4.624130] sp : ffff00001002b570
> [    4.627428] x29: ffff00001002b570 x28: ffff0000107b558c
> [    4.632715] x27: 0000000000000000 x26: 0000000000000000
> [    4.638002] x25: ffff0000107dc000 x24: ffff800014690c00
> [    4.643288] x23: ffff00001002b6cc x22: ffff800014690c10
> [    4.648576] x21: ffff00001002b6cc x20: ffff800014672800
> [    4.653862] x19: 0000000000000000 x18: ffffffffffffffff
> [    4.659148] x17: 0000000000000007 x16: 0000000000000001
> [    4.664434] x15: ffff000010716000 x14: ffffffffff000000
> [    4.669721] x13: 0000000000001000 x12: 0000000000000038
> [    4.675007] x11: 0000000000000010 x10: 0101010101010101
> [    4.680293] x9 : 0000000000000008 x8 : 0000000000000008
> [    4.685579] x7 : 0000000000000000 x6 : ffff0000107dc548
> [    4.690865] x5 : 0000000000000003 x4 : ffff000010091d98
> [    4.696151] x3 : ffff000010412948 x2 : ffff000010412790
> [    4.701437] x1 : 0000000000000000 x0 : ffff000010045100
> [    4.706725] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    4.713393] Call trace:
> [    4.715828]  regmap_mmio_read32le+0x24/0x48
> [    4.719991]  regmap_mmio_read+0x48/0x70
> [    4.723811]  _regmap_bus_reg_read+0x38/0x48
> [    4.727974]  _regmap_read+0x6c/0x1a8
> [    4.731533]  regmap_read+0x50/0x78
> [    4.734921]  altr_sdram_probe+0x98/0x5f0
> [    4.738828]  platform_drv_probe+0x58/0xb8
> [    4.742819]  really_probe+0x1d4/0x3d8
> [    4.746463]  driver_probe_device+0x70/0x158
> [    4.750627]  __device_attach_driver+0xbc/0x140
> [    4.755049]  bus_for_each_drv+0x80/0xe0
> [    4.758866]  __device_attach+0xe8/0x170
> [    4.762684]  device_initial_probe+0x24/0x30
> [    4.766847]  bus_probe_device+0xa0/0xa8
> [    4.770666]  device_add+0x3d4/0x5f0
> [    4.774140]  of_device_add+0x5c/0x70
> [    4.777698]  of_platform_device_create_pdata+0xc4/0x128
> [    4.782898]  of_platform_bus_create+0x1d0/0x4e0
> [    4.787405]  of_platform_populate+0x84/0x150
> [    4.791655]  altr_edac_a10_probe+0x388/0x428
> [    4.795904]  platform_drv_probe+0x58/0xb8
> [    4.799895]  really_probe+0x1d4/0x3d8
> [    4.803539]  driver_probe_device+0x70/0x158
> [    4.807702]  __driver_attach+0x12c/0x148
> [    4.811606]  bus_for_each_dev+0x78/0xe0
> [    4.815422]  driver_attach+0x30/0x40
> [    4.818980]  bus_add_driver+0x1c0/0x288
> [    4.822797]  driver_register+0x68/0x118
> [    4.826614]  __platform_driver_register+0x54/0x60
> [    4.831299]  altr_edac_a10_driver_init+0x24/0x2c
> [    4.835896]  do_one_initcall+0xcc/0x230
> [    4.839714]  kernel_init_freeable+0x290/0x384
> [    4.844051]  kernel_init+0x18/0x110
> [    4.847525]  ret_from_fork+0x10/0x1c
> [    4.851085] Code: 2a0103f3 d503201f f9400280 8b334000 (b9400000)
> [    4.857154] ---[ end trace 416494f6b96edb9b ]---
> 
> After the commit 3123c5c4ca15 ("edac: altera: Move Stratix10 SDRAM ECC
> to peripheral") the crash location is now at altr_check_ecc_deps(),
> but I think the cause is still the same:
> 
> [    4.996439] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
> [    5.003892] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-aakoskin+ #10
> [    5.010645] Hardware name: SoCFPGA Stratix 10 test (DT)
> [    5.015846] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [    5.020623] pc : altr_check_ecc_deps+0x28/0x70
> [    5.025046] lr : altr_edac_a10_device_add+0x19c/0x388
> [    5.030071] sp : ffff80001002b9f0
> [    5.033368] x29: ffff80001002b9f0 x28: ffff80001002ba88
> [    5.038657] x27: ffff8000104cd000 x26: ffff8000106a82c0
> [    5.043943] x25: ffff800010848000 x24: ffff00007fc007a0
> [    5.049230] x23: ffff00007fc00570 x22: ffff0000146e3000
> [    5.054516] x21: ffff000014728880 x20: 0000000010035100
> [    5.059803] x19: ffff0000146e32a8 x18: ffff800010035fff
> [    5.065089] x17: 000000000000000e x16: 0000000000000007
> [    5.070375] x15: ffff800010035fff x14: 00000000f8012000
> [    5.075661] x13: 0000000000000000 x12: ffff80001077c000
> [    5.080947] x11: 0040000000000001 x10: 0040000000000041
> [    5.086233] x9 : 0400000000000001 x8 : ffff800010036000
> [    5.091520] x7 : 0000000000000000 x6 : 0000000000000001
> [    5.096807] x5 : 0000000000000001 x4 : ffff0000146f4000
> [    5.102094] x3 : ffff0000146f4100 x2 : 0000000000000000
> [    5.107380] x1 : ffff8000106a82c0 x0 : ffff800010035100
> [    5.112667] Call trace:
> [    5.115101]  altr_check_ecc_deps+0x28/0x70
> [    5.119178]  altr_edac_a10_device_add+0x19c/0x388
> [    5.123859]  altr_edac_a10_probe+0x1c0/0x3d0
> [    5.128111]  platform_drv_probe+0x58/0xb8
> [    5.132102]  really_probe+0x1d4/0x430
> [    5.135746]  driver_probe_device+0x70/0x158
> [    5.139908]  device_driver_attach+0x74/0x80
> [    5.144071]  __driver_attach+0xa0/0x198
> [    5.147889]  bus_for_each_dev+0x78/0xe0
> [    5.151706]  driver_attach+0x30/0x40
> [    5.155263]  bus_add_driver+0x178/0x228
> [    5.159080]  driver_register+0x68/0x118
> [    5.162898]  __platform_driver_register+0x54/0x60
> [    5.167583]  altr_edac_a10_driver_init+0x24/0x2c
> [    5.172181]  do_one_initcall+0xd4/0x240
> [    5.175997]  kernel_init_freeable+0x1c0/0x260
> [    5.180336]  kernel_init+0x18/0x110
> [    5.183811]  ret_from_fork+0x10/0x18
> [    5.187373] Code: f9401261 f9400a60 b9802c22 8b020000 (b9400000)
> [    5.193440] ---[ end trace cdc4aebcaf1288ee ]---
> 
> Was this register access change intentional? How the driver probe should
> work when the ECC is not present?
> 
The altr_check_ecc_deps() call is checking whether ECC is enabled so the 
probe should fail.

I suspect the device tree. Can you verify the following node is in your 
device tree?

	sdramedac {
		compatible = "altr,sdram-edac-s10";
		altr,sdr-syscon = <&sdr>;
		interrupts = <16 4>;
	};

I'll keep looking into this as well.

Thor

> A.
> 

