Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2E2916BF
	for <lists+linux-edac@lfdr.de>; Sun, 18 Oct 2020 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgJRJbv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 18 Oct 2020 05:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgJRJbu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 18 Oct 2020 05:31:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B6C061755;
        Sun, 18 Oct 2020 02:31:50 -0700 (PDT)
Received: from zn.tnic (p200300ec2f250700a5e1031723796584.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:700:a5e1:317:2379:6584])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D27421EC02FE;
        Sun, 18 Oct 2020 11:31:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603013507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VFKODLuyOgKKXp9FcqrwOHVci3YsZ6RrEiDYWGEJ+zQ=;
        b=LcvN2z65npRCkYehn8kI+ynq4YOOvoHnJEqnnTz549q+0YVuAdIdRxSeI3nZdqROS+WE6v
        MLJjzq3MGQG/mBHE5767zEI907Zsw/qy5GVujqPbaHJ6k20F8/oaUWBLsZhH7RYXxGeOhw
        Q/qYHlStM+EUCsQn75VPw5jv70TRnc8=
Date:   Sun, 18 Oct 2020 11:31:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: Re: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver
Message-ID: <20201018093135.GA8364@zn.tnic>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-6-git-send-email-franck.lenormand@oss.nxp.com>
 <20200819133136.GB7114@dragon>
 <AM6PR04MB496668D6EE3D07C78C5FE77E80010@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB496668D6EE3D07C78C5FE77E80010@AM6PR04MB4966.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Oct 18, 2020 at 05:21:28AM +0000, Aisheng Dong wrote:
> Not sure if EDAC could be a better place.
> e.g.
> drivers/edac/sifive_edac.c

I don't see how this functionality has anything to do with EDAC.

> If not, maybe we can put in 'soc' first.

Or drivers/misc/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
