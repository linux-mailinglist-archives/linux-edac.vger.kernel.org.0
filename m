Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21868504EBB
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiDRKW4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiDRKWs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 06:22:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38DA1A9;
        Mon, 18 Apr 2022 03:20:09 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ab329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ab:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2FCD1EC04D6;
        Mon, 18 Apr 2022 12:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650277204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NXeX+tW5CYGuT5f0Ebev+zI07XzqiYURQIBYynhO5Qk=;
        b=YW53q01ClnUEQTNIheCh8GhlWA9j3LsGXRbjG55/M01BaYex4+zL4Xiw6ynImsZApshNaf
        zH2li/dc7oI60c462Vbo89ZF9vg8kO77hrUDstxlXWoT9z3ibKIrfQjZdUWa86ymXbHNeX
        2718YnaGvQa4fOmUCLDiltG9M6n5JgY=
Date:   Mon, 18 Apr 2022 12:20:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Message-ID: <Yl07U34H0V+XM8aV@zn.tnic>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <AS8PR04MB84044DD3E5EC879F7C281B9792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Yl0iqXnsFm8rMBms@zn.tnic>
 <AS8PR04MB840435F6BACFF0C7F9B6D90792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR04MB840435F6BACFF0C7F9B6D90792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 10:12:14AM +0000, Sherry Sun wrote:
> Hi Borislav, thanks for the info.

You're welcome.

I'd appreciate it, though, if you do not top-post on public mailing
lists but reply underneath the text you're quoting, just like I did.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
