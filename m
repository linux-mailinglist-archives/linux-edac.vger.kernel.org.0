Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB914DC68A
	for <lists+linux-edac@lfdr.de>; Thu, 17 Mar 2022 13:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiCQMy7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Mar 2022 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiCQMxB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Mar 2022 08:53:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF51FAA0B;
        Thu, 17 Mar 2022 05:50:47 -0700 (PDT)
Received: from [127.0.0.1] (pd95ca587.dip0.t-ipconnect.de [217.92.165.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C17BE1EC063F;
        Thu, 17 Mar 2022 13:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647521442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EY+OVlK3FNjPeuxT1E19uUsmlLA7v3Vf0nxQLY63VP8=;
        b=QMbTN2lzFuaJF5Ls5pbKgje3WyjB6xCyDSeGcHyA/A65kzY3q58KzvglWSOzq/ZQ6851av
        pQKmCvSgjj6ZEKSEns6SZpuEOouk2AzEOLxqtxxYFbt9V9X+Jc2ZNnW1uSqOArBuptgc1U
        pdM+HDeptKw1t7S5XFAjwrY6lp/QIEk=
Date:   Thu, 17 Mar 2022 12:50:38 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, YSCHU@nuvoton.com, mchehab@kernel.org,
        tony.luck@intel.com, benjaminfair@google.com, venture@google.com,
        KWLIU@nuvoton.com, robh+dt@kernel.org, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, yuenn@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, ctcchien@nuvoton.com
CC:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v5 3/3] EDAC: nuvoton: Add NPCM memory controller driver
User-Agent: K-9 Mail for Android
In-Reply-To: <20220317015854.18864-4-ctcchien@nuvoton.com>
References: <20220317015854.18864-1-ctcchien@nuvoton.com> <20220317015854.18864-4-ctcchien@nuvoton.com>
Message-ID: <37361667-C932-4139-B649-52DE029BDEE5@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On March 17, 2022 1:58:54 AM UTC, Medad CChien <medadyoung@gmail=2Ecom> wro=
te:
>Add support for Nuvoton NPCM SoC=2E
>
>Signed-off-by: Medad CChien <ctcchien@nuvoton=2Ecom>
>Reported-by: kernel test robot <lkp@intel=2Ecom>

What exactly has the robot reported here?

>---
> drivers/edac/Kconfig     |   9 +
> drivers/edac/Makefile    |   1 +
> drivers/edac/npcm_edac=2Ec | 710 +++++++++++++++++++++++++++++++++++++++
> 3 files changed, 720 insertions(+)
> create mode 100644 drivers/edac/npcm_edac=2Ec

I don't see a MAINTAINERS file entry so that people can Cc you on bugs=2E =
See the other EDAC drivers for an example=2E=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
