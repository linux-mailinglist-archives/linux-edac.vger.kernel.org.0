Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F7112C8A
	for <lists+linux-edac@lfdr.de>; Wed,  4 Dec 2019 14:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfLDNZp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Dec 2019 08:25:45 -0500
Received: from mail-eopbgr00133.outbound.protection.outlook.com ([40.107.0.133]:15014
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbfLDNZp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Dec 2019 08:25:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5mhgU0FVSk63O2a/5Bp6PVjxo/CE3VmrtXnAO7NNTxgfSHPyJWQJaxvDgEYi8YvThSFWGMBGPV42GgMI1yX9OLoEeemko/stKzY5mpo0ocEXvdvptU3w2aB0lW01RKaTcw5FlWcl2hTw0IRDpoHNWTORv6agVEB6VUv71s1EzvIEkcNo6v42Q780vfQz1IvCOLPuTNqI6Y5EyqZ9DYpTT7bgB8Xmdkwi3KgO59oRsZu2gni+rIPES30RURi+rhbY//3c/ch4F8ZcVH26BmCfDfmqNe2BY3NMi7Za2d/PcpQbsbAuENYXLA8odaOEaawbUexvTd2MGAPAt1yLkX4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYNJ9TLX02JGfhkts0R0CAQ/wIYBSErQXgdfikilA8I=;
 b=AO4Tk/EK/gF8jCQMHBr0iA3y22u5I2F/q1XX2eSb66bwKz8oXzHfdNZedTLM/Hu+J21pTC2dl0zNRuHYvwxvMzRgEcMX6Hp3ohXyI0/KS5UYo77psJJEzSCilhh98s8dLazVWDbAWnmL+nuvl9DySrABr3jQdq87TqXxLwWSy+z0Mx0Azec48lClTfICy4s8rKkkh4JCBpVNSF1o1GQ9IcUcvB4emWV9ac6s4JcVZ8abfm7aeqd9NYaRKWF37lQk8vOFvh/hnovANohqaqxwJIAXBPe7rLOHe2UlD+FPuSbew1UcO7FVYd5jldMJp8GYoaV8OkfGdeDS4S82zTy0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYNJ9TLX02JGfhkts0R0CAQ/wIYBSErQXgdfikilA8I=;
 b=CmP5Mrnf4DXMxMj9NmFymUmX50Et3rjAwUztIzFbVBmU8+yO9O8rjvpRwp7nF3KLn84hOwGqj7vUaVx2J90RWqxYHKYgDpFuOZ2rJN61Pu8LE4knLVcu0zc0vdAyg92Rc2CYpU3sWkNHc7Q7tchk3RF0rBDPBOBll73jsLfQRro=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
Received: from VI1PR07MB6174.eurprd07.prod.outlook.com (20.178.9.83) by
 AM6SPR01MB04.eurprd07.prod.outlook.com (52.133.25.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.4; Wed, 4 Dec 2019 13:25:39 +0000
Received: from VI1PR07MB6174.eurprd07.prod.outlook.com
 ([fe80::952d:44a4:f9ab:4056]) by VI1PR07MB6174.eurprd07.prod.outlook.com
 ([fe80::952d:44a4:f9ab:4056%3]) with mapi id 15.20.2516.013; Wed, 4 Dec 2019
 13:25:39 +0000
Date:   Wed, 4 Dec 2019 15:25:31 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [Bisected] altera_edac crash on a system without ECC
Message-ID: <20191204132531.GA22600@ak-laptop.emea.nsn-net.net>
References: <20191129165739.GA2583@ak-laptop.emea.nsn-net.net>
 <3bbd2890-ffcc-39df-8ab6-ecf72d92a006@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbd2890-ffcc-39df-8ab6-ecf72d92a006@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To VI1PR07MB6174.eurprd07.prod.outlook.com
 (2603:10a6:803:a5::19)
MIME-Version: 1.0
Received: from ak-laptop.emea.nsn-net.net (131.228.2.10) by HE1PR0402CA0001.eurprd04.prod.outlook.com (2603:10a6:3:d0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 4 Dec 2019 13:25:39 +0000
X-Originating-IP: [131.228.2.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d439247d-8267-4577-2b71-08d778bd7478
X-MS-TrafficTypeDiagnostic: AM6SPR01MB04:
X-Microsoft-Antispam-PRVS: <AM6SPR01MB04F9128134A19CF38F1099F45D0@AM6SPR01MB04.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(51444003)(66946007)(4326008)(16586007)(25786009)(58126008)(33656002)(6436002)(66556008)(66476007)(6506007)(229853002)(53546011)(6116002)(7696005)(81166006)(81156014)(3846002)(6666004)(478600001)(6246003)(76176011)(52116002)(8936002)(316002)(8676002)(23726003)(86362001)(14444005)(1076003)(956004)(2906002)(9686003)(305945005)(55016002)(5660300002)(6916009)(50466002)(26005)(186003)(16526019)(44832011)(7736002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6SPR01MB04;H:VI1PR07MB6174.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOLRyEMuqRJ/kyFHrluvZg1vMV/cTgSMmu3BwrUbqXqFpmwkDIDFg/+KmQncXxxILnr5vgFUAWXcoRYVXwWT6U09XVsMyYk1ZgVn1gc5ZLBwQdkUHi7Q16XVDKYAchUzeXKlHsrHqX0rC/xigXNzZ9rEO8nLyRm0qJiQwMvD5I5XjJ3qRd8SzF7YzpoPAHCLRAg5wHVpTNtRA1MrrdXGkAf/mHVvU9P8+YS3G8LkFCJRUDTZAZLR/UQMAZLE3iGmlb8/5SgdN+F5GMJdbgL5bNMJ3ZxZ6NokmV8cgMr9psA/Mk7l1SexgdOJsr1dAnNVP2tm+zU2y6nYu1PmmR5GWC5IHkXOK4yrar81Ja/irQ43Qozx4WhdH/0gX3NCRYnI6M3aA7+FXbsWy9HaVt1c2YHcETtK5HDhPTYaWcJy5SnNwNkzurR+QyKhv9uYHDUSutcTTrtYc/4NwLQgUT9ErCL30e+kja7fvFEfWOjsLK8Tgo2TPS/rYI9OfCLZRlZr
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d439247d-8267-4577-2b71-08d778bd7478
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 13:25:39.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkVi3mBZjIuuqFPj7ct9zuad6hrCvjIrj2Ck0AleP3bgAIbZURu46rFXBnUi8Gi+wOYLYsOxnEdgQcbKLhXcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB04
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Tue, Dec 03, 2019 at 05:09:48PM -0600, Thor Thayer wrote:
> On 11/29/19 10:57 AM, Aaro Koskinen wrote:
> >Hi,
> >
> >I tried booting v5.4 mainline kernel on a stratix10 board with ECC
> >disabled, and the altera-edac driver (with only SDRAM enabled) is
> >now crashing the system instead of failing the probe with "No ECC/ECC
> >disabled".
> >
> I apologize for the late reply. I was on vacation.
> 
> ECC disabled means the sof/jic that you're loading has ECC disabled,
> correct?

Yes.

> >This seems to have started with commit 08f08bfb7b4c ("EDAC, altera:
> >Merge Stratix10 into the Arria10 SDRAM probe routine"). With the change,
> >looks like sdram probe no longer uses SMC calls and instead accesses
> >the registers directly. The crash looks like this:
> 
> I haven't seen this. I'd expect both ECC enabled and disabled to fail with
> the dumps you have below since they'd both need to use the regmap functions.

With ECC enabled it doesn't fail, as the direct register access appears
to work then (I also checked by reading 0xf8011101 from userspace -
and it works without an abort).

> Yes, this does look like it is using the register accesses instead of the
> SMC call. Line 2206 sets the SMC call after determining from the if()
> statement if it is a Stratix10 or Arria10 and from below it seems to take
> the Arria10 path.

But that's setting the ecc_mgr_map. I think that altr_check_ecc_deps
and altr_sdram_probe use a different mapping. Before commit 08f08bfb7b4c
there was S10 specific altr_s10_sdram_probe() that took care of the SMC,
but I cannot see how the current code doing that unless I'm missing some
special magic.

> The altr_check_ecc_deps() call is checking whether ECC is enabled so the
> probe should fail.
> 
> I suspect the device tree. Can you verify the following node is in your
> device tree?
> 
> 	sdramedac {
> 		compatible = "altr,sdram-edac-s10";
> 		altr,sdr-syscon = <&sdr>;
> 		interrupts = <16 4>;
> 	};

Yes, I'm using the in-tree socfpga_stratix10.dtsi.

A.
