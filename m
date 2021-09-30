Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5741DC34
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbhI3O0t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 10:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348704AbhI3O0t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 30 Sep 2021 10:26:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545DC06176A
        for <linux-edac@vger.kernel.org>; Thu, 30 Sep 2021 07:25:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mVwzg-0007y2-Sk; Thu, 30 Sep 2021 16:25:04 +0200
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1mVwzg-0005e1-Al; Thu, 30 Sep 2021 16:25:04 +0200
Message-ID: <a3550d31dd72faeb6219d878cc7920dd11a1a5fb.camel@pengutronix.de>
Subject: Re: Bug in EDAC error handling of Marvell Armada XP
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     "Potsch, Hans (Nokia - DE/Stuttgart)" <hans.potsch@nokia.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc:     "Glock, Harald (Nokia - DE/Stuttgart)" <harald.glock@nokia.com>
Date:   Thu, 30 Sep 2021 16:25:04 +0200
In-Reply-To: <AM8PR07MB8172B5AB7AD5DAE78CA4624CFEAA9@AM8PR07MB8172.eurprd07.prod.outlook.com>
References: <AM8PR07MB8172B5AB7AD5DAE78CA4624CFEAA9@AM8PR07MB8172.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hans,

On Thu, 2021-09-30 at 12:55 +0000, Potsch, Hans (Nokia - DE/Stuttgart) wrote:
> Hi Jan, all,
>  
> we recently discovered strange traces when our system is experiencing ECC
> errors.
>  
> When system is detecting ECC errors it sometimes reports the same amount of CE
> and UE (correctable and uncorrectable errors) or sometimes even 0 UE.
> Please see these examples:
>  
> EDAC MC0: 3 CE marvell,armada-xp-sdram-controller on any memory ( page:0x0
> offset:0x0 grain:8 syndrome:0x0 - details unavailable (multiple errors))
> EDAC MC0: 3 UE marvell,armada-xp-sdram-controller on any memory ( page:0x0
> offset:0x0 grain:8 - details unavailable (multiple errors))
>  
> EDAC MC0: 0 UE marvell,armada-xp-sdram-controller on any memory ( page:0x0
> offset:0x0 grain:8 - details unavailable (multiple errors))
>  
> While looking at the code we noticed that in the drivers/edac/armada_xp_edac.c
> file the probably incorrect parameter is passed to the edac_mc_handle_error()
> function.
>
> Please see the following git diff which should pass the correct parameter
> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> index e3e757513d1b..b1f46a974b9e 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -178,7 +178,7 @@ static void axp_mc_check(struct mem_ctl_info *mci)
>                                      "details unavailable (multiple errors)");
>         if (cnt_dbe)
>                 edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> -                                    cnt_sbe, /* error count */
> +                                    cnt_dbe, /* error count */
>                                      0, 0, 0, /* pfn, offset, syndrome */
>                                      -1, -1, -1, /* top, mid, low layer */
>                                      mci->ctl_name,

Yes, this is a bug and your fix looks correct.

> Currently our system is running kernel version 5.10.49.
> Investigation showed, that also latest RC still has this bug 
> armada_xp_edac.c - drivers/edac/armada_xp_edac.c - Linux source code (v5.15-
> rc3) - Bootlin

Were you able to verify that your change fixes the issue? If so, I'd ack a
properly formatted patch submission.

I don't have access to the hardware at the moment, so I can't easily test it
myself.

Thanks,
Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
