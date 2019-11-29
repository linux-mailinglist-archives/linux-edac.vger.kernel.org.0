Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27510D8BB
	for <lists+linux-edac@lfdr.de>; Fri, 29 Nov 2019 17:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK2Q5y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Nov 2019 11:57:54 -0500
Received: from mail-eopbgr00130.outbound.protection.outlook.com ([40.107.0.130]:9539
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbfK2Q5y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 Nov 2019 11:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGmGskv/3ci/X6nf7Bt+tdROAmYW7pBEoUmw19KHSE3Jp1pGOXvsGNz25tfc2k0rHRlUmTirtWu8WibqFcSNw9lXq2KlGySp9k0XVJpE0hRoQBEGvWGATZeQFcomChikSstlyvIIigGMd/RWSSQCc3VxSagPrahizx2rEwcdntrCpbWgFz/sJRqufiYvX0M4hBSaXozv/2xbQAbnyLjDUM8fw+1ckl4LZtu7z9eEI97meLm2LYtjOO4gRweRnNXae9NT1ryugomdpptnN+ZITaZ+MkWQ7nqmyAVk/0KAFrjnLRbkwhIer0k1w5xgxRCus21H6K9RF3m7gFdLTqHLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE19dATV/jR4cqeVPRXmnjgCHv+NhU6Xj6uwrtwLaGk=;
 b=Jolzu1KZGvkUxMlwvpO1jU5ksmPKbCj37AsBX9HW9LZ94pPAfbFxYNytcFC4FFoQ2fqjyLzukb43CZHDXYvL9JM1+lDGDJ8dNlaE6Q3R1bEBRw0d7x0Z4fBMMX3Ig2nqsBFrHW2+jOZZZLjyhxOYuUyDpZd6vY5z6odMBUVOKYKLtUH1af0P5BhuSEbFAr4+m8LS4CbLssHOqQt7M6ad1/FvSywWK0yf2A83lKzN1E4H3vRP1bjeozozZVrmXjcS1CynQErBQHq+YjeV+08/bEWe4WxjJWhReRsKJiuBC5oSGPbMPfG/t8sZ9uzmeQCJnReDo4FSH57nYair1iBNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE19dATV/jR4cqeVPRXmnjgCHv+NhU6Xj6uwrtwLaGk=;
 b=HJnE+T2Tyuab2g711cndfPX5Yq9K82SU7YUE/4yWiXIwduabWIOgyEDLu/s3pFphq1h8yNtC/L0//Db6qYPISvEGlDkgyswtJbef0ElpAMv64Lm/5W5HdMRX9D5ONNxqb6gfIXtkylhWMd18WdDTynesGYtUeL2XipRdoLcp0SM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
Received: from VI1PR07MB6174.eurprd07.prod.outlook.com (20.178.9.83) by
 VI1PR07MB4510.eurprd07.prod.outlook.com (20.177.56.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.10; Fri, 29 Nov 2019 16:57:48 +0000
Received: from VI1PR07MB6174.eurprd07.prod.outlook.com
 ([fe80::952d:44a4:f9ab:4056]) by VI1PR07MB6174.eurprd07.prod.outlook.com
 ([fe80::952d:44a4:f9ab:4056%3]) with mapi id 15.20.2516.003; Fri, 29 Nov 2019
 16:57:48 +0000
Date:   Fri, 29 Nov 2019 18:57:39 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [Bisected] altera_edac crash on a system without ECC
Message-ID: <20191129165739.GA2583@ak-laptop.emea.nsn-net.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HE1PR0902CA0019.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::29) To VI1PR07MB6174.eurprd07.prod.outlook.com
 (2603:10a6:803:a5::19)
MIME-Version: 1.0
Received: from ak-laptop.emea.nsn-net.net (131.228.2.10) by HE1PR0902CA0019.eurprd09.prod.outlook.com (2603:10a6:3:e5::29) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 29 Nov 2019 16:57:48 +0000
X-Originating-IP: [131.228.2.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f5e5d01-81ab-4e90-a956-08d774ed4364
X-MS-TrafficTypeDiagnostic: VI1PR07MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB451029F50A12CFCE576D56D0F4460@VI1PR07MB4510.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0236114672
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(5660300002)(478600001)(14444005)(5024004)(25786009)(33656002)(305945005)(7736002)(50466002)(66946007)(81166006)(6916009)(2906002)(81156014)(8676002)(8936002)(1076003)(66556008)(66476007)(66066001)(47776003)(6666004)(3846002)(4326008)(6436002)(52116002)(55016002)(9686003)(26005)(956004)(44832011)(386003)(6506007)(16586007)(6116002)(316002)(23726003)(7696005)(58126008)(186003)(86362001)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4510;H:VI1PR07MB6174.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sw0d21/fZlYUR44+1yE+SL19HVIOhpm9M1GWkohMuG0u6P8iUdkdrp5H+pjFlj6xjWjvc+5f+FOo+dhwSZxwpyTLFZSh+21fmKVMWXoiFYJNwfr8rjq3KADRYwAEC3P9URFaTntQmxVBlPwc8aXAyij3pVTKb+DiDPkNP3VFVjvm8/cLDrUao77RqhrrvySzNNjAnnbqk4Ddrgdgh9M6ED3QLcSn1ldxJ7fQBe2tZGK1mQU4jmaycbwq4S7Laah1vAf/viTOZzmLeKZd7ig8vV3M9RUaBJBGAQvSRbzYlM4KL0/YUVNNXfETIZNXwJ7MHbTgjzmxdTgVfCWTdPgqCYcBsjdlRGYpUJdvc8YLtIQu8QHjcu95e3Om9mZcx5wifnZoPQURFX2RWUy7Pha+X75+tFVsz4G8HO72Qzdh59Y9neSCer/TLFDRm40W6kT0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5e5d01-81ab-4e90-a956-08d774ed4364
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 16:57:48.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceWV2pnGslVS2c6gtbwuRzOpPsIZPdxwdnfCAJGeu9d9iUp3VqZ7H0CsHauiGx1LM8FzTbcYwPgYinVePj1cTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4510
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

I tried booting v5.4 mainline kernel on a stratix10 board with ECC
disabled, and the altera-edac driver (with only SDRAM enabled) is
now crashing the system instead of failing the probe with "No ECC/ECC
disabled".

This seems to have started with commit 08f08bfb7b4c ("EDAC, altera:
Merge Stratix10 into the Arria10 SDRAM probe routine"). With the change,
looks like sdram probe no longer uses SMC calls and instead accesses
the registers directly. The crash looks like this:

[    4.591371] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
[    4.598816] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-aakoskin+ #8
[    4.605483] Hardware name: SoCFPGA Stratix 10 test (DT)
[    4.610683] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    4.615461] pc : regmap_mmio_read32le+0x24/0x48
[    4.619969] lr : regmap_mmio_read+0x48/0x70
[    4.624130] sp : ffff00001002b570
[    4.627428] x29: ffff00001002b570 x28: ffff0000107b558c
[    4.632715] x27: 0000000000000000 x26: 0000000000000000
[    4.638002] x25: ffff0000107dc000 x24: ffff800014690c00
[    4.643288] x23: ffff00001002b6cc x22: ffff800014690c10
[    4.648576] x21: ffff00001002b6cc x20: ffff800014672800
[    4.653862] x19: 0000000000000000 x18: ffffffffffffffff
[    4.659148] x17: 0000000000000007 x16: 0000000000000001
[    4.664434] x15: ffff000010716000 x14: ffffffffff000000
[    4.669721] x13: 0000000000001000 x12: 0000000000000038
[    4.675007] x11: 0000000000000010 x10: 0101010101010101
[    4.680293] x9 : 0000000000000008 x8 : 0000000000000008
[    4.685579] x7 : 0000000000000000 x6 : ffff0000107dc548
[    4.690865] x5 : 0000000000000003 x4 : ffff000010091d98
[    4.696151] x3 : ffff000010412948 x2 : ffff000010412790
[    4.701437] x1 : 0000000000000000 x0 : ffff000010045100
[    4.706725] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    4.713393] Call trace:
[    4.715828]  regmap_mmio_read32le+0x24/0x48
[    4.719991]  regmap_mmio_read+0x48/0x70
[    4.723811]  _regmap_bus_reg_read+0x38/0x48
[    4.727974]  _regmap_read+0x6c/0x1a8
[    4.731533]  regmap_read+0x50/0x78
[    4.734921]  altr_sdram_probe+0x98/0x5f0
[    4.738828]  platform_drv_probe+0x58/0xb8
[    4.742819]  really_probe+0x1d4/0x3d8
[    4.746463]  driver_probe_device+0x70/0x158
[    4.750627]  __device_attach_driver+0xbc/0x140
[    4.755049]  bus_for_each_drv+0x80/0xe0
[    4.758866]  __device_attach+0xe8/0x170
[    4.762684]  device_initial_probe+0x24/0x30
[    4.766847]  bus_probe_device+0xa0/0xa8
[    4.770666]  device_add+0x3d4/0x5f0
[    4.774140]  of_device_add+0x5c/0x70
[    4.777698]  of_platform_device_create_pdata+0xc4/0x128
[    4.782898]  of_platform_bus_create+0x1d0/0x4e0
[    4.787405]  of_platform_populate+0x84/0x150
[    4.791655]  altr_edac_a10_probe+0x388/0x428
[    4.795904]  platform_drv_probe+0x58/0xb8
[    4.799895]  really_probe+0x1d4/0x3d8
[    4.803539]  driver_probe_device+0x70/0x158
[    4.807702]  __driver_attach+0x12c/0x148
[    4.811606]  bus_for_each_dev+0x78/0xe0
[    4.815422]  driver_attach+0x30/0x40
[    4.818980]  bus_add_driver+0x1c0/0x288
[    4.822797]  driver_register+0x68/0x118
[    4.826614]  __platform_driver_register+0x54/0x60
[    4.831299]  altr_edac_a10_driver_init+0x24/0x2c
[    4.835896]  do_one_initcall+0xcc/0x230
[    4.839714]  kernel_init_freeable+0x290/0x384
[    4.844051]  kernel_init+0x18/0x110
[    4.847525]  ret_from_fork+0x10/0x1c
[    4.851085] Code: 2a0103f3 d503201f f9400280 8b334000 (b9400000)
[    4.857154] ---[ end trace 416494f6b96edb9b ]---

After the commit 3123c5c4ca15 ("edac: altera: Move Stratix10 SDRAM ECC
to peripheral") the crash location is now at altr_check_ecc_deps(),
but I think the cause is still the same:

[    4.996439] Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
[    5.003892] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-aakoskin+ #10
[    5.010645] Hardware name: SoCFPGA Stratix 10 test (DT)
[    5.015846] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    5.020623] pc : altr_check_ecc_deps+0x28/0x70
[    5.025046] lr : altr_edac_a10_device_add+0x19c/0x388
[    5.030071] sp : ffff80001002b9f0
[    5.033368] x29: ffff80001002b9f0 x28: ffff80001002ba88
[    5.038657] x27: ffff8000104cd000 x26: ffff8000106a82c0
[    5.043943] x25: ffff800010848000 x24: ffff00007fc007a0
[    5.049230] x23: ffff00007fc00570 x22: ffff0000146e3000
[    5.054516] x21: ffff000014728880 x20: 0000000010035100
[    5.059803] x19: ffff0000146e32a8 x18: ffff800010035fff
[    5.065089] x17: 000000000000000e x16: 0000000000000007
[    5.070375] x15: ffff800010035fff x14: 00000000f8012000
[    5.075661] x13: 0000000000000000 x12: ffff80001077c000
[    5.080947] x11: 0040000000000001 x10: 0040000000000041
[    5.086233] x9 : 0400000000000001 x8 : ffff800010036000
[    5.091520] x7 : 0000000000000000 x6 : 0000000000000001
[    5.096807] x5 : 0000000000000001 x4 : ffff0000146f4000
[    5.102094] x3 : ffff0000146f4100 x2 : 0000000000000000
[    5.107380] x1 : ffff8000106a82c0 x0 : ffff800010035100
[    5.112667] Call trace:
[    5.115101]  altr_check_ecc_deps+0x28/0x70
[    5.119178]  altr_edac_a10_device_add+0x19c/0x388
[    5.123859]  altr_edac_a10_probe+0x1c0/0x3d0
[    5.128111]  platform_drv_probe+0x58/0xb8
[    5.132102]  really_probe+0x1d4/0x430
[    5.135746]  driver_probe_device+0x70/0x158
[    5.139908]  device_driver_attach+0x74/0x80
[    5.144071]  __driver_attach+0xa0/0x198
[    5.147889]  bus_for_each_dev+0x78/0xe0
[    5.151706]  driver_attach+0x30/0x40
[    5.155263]  bus_add_driver+0x178/0x228
[    5.159080]  driver_register+0x68/0x118
[    5.162898]  __platform_driver_register+0x54/0x60
[    5.167583]  altr_edac_a10_driver_init+0x24/0x2c
[    5.172181]  do_one_initcall+0xd4/0x240
[    5.175997]  kernel_init_freeable+0x1c0/0x260
[    5.180336]  kernel_init+0x18/0x110
[    5.183811]  ret_from_fork+0x10/0x18
[    5.187373] Code: f9401261 f9400a60 b9802c22 8b020000 (b9400000)
[    5.193440] ---[ end trace cdc4aebcaf1288ee ]---

Was this register access change intentional? How the driver probe should
work when the ECC is not present?

A.
