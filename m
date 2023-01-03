Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5765C422
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 17:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjACQlU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 11:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjACQlT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 11:41:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384C510575;
        Tue,  3 Jan 2023 08:41:18 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4E301EC050B;
        Tue,  3 Jan 2023 17:41:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672764076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xmDlBK064u6tv995CyG4zNhAkiZyVidiZwai0Nu5Xgo=;
        b=LYnVwSreCEcdShYtVwISxsckH74h+vdxbXCS1FZB+752d11J2eM8R6UC++gquJepvfA4S8
        BpHRkUXQ60OZPWO2o7AzYRRpzYOmQozT/rXcify3g8iHoxsqOCQstoamSBSjRy1duGswQf
        YMmhNu1hCDihmQQALWCricp/ScuatyE=
Date:   Tue, 3 Jan 2023 17:41:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: highbank: Fix memory leak in highbank_mc_probe
Message-ID: <Y7Rap4dAwJzM2HpV@zn.tnic>
References: <20221229054825.1361993-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221229054825.1361993-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 29, 2022 at 09:48:24AM +0400, Miaoqian Lin wrote:
> edac_mc_alloc() allocates memory. The memory are not released
> when devres_open_group() fails, which causes memory leak.
> Call edac_mc_free() in the error handling to fix this.
> 
> Fixes: a1b01edb2745 ("edac: add support for Calxeda highbank memory controller")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> altr_sdram_probe() performs similar operations,
> I take it as reference.
> ---
>  drivers/edac/highbank_mc_edac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
