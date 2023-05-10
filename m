Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502126FDF67
	for <lists+linux-edac@lfdr.de>; Wed, 10 May 2023 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbjEJOAX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 May 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjEJOAW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 May 2023 10:00:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06587110;
        Wed, 10 May 2023 07:00:13 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 270A61EC0683;
        Wed, 10 May 2023 16:00:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683727211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8Gb9uzOvIdJe7LkqExarSzYl5Rjwlu2HzfnqUUy6fOo=;
        b=QALSyXOMc00+oN9gqqh3Okrbna8LHkU0UEUfEu7Z0AJUNN0jQR2LuwJq0PsXrcBHLNizMf
        otqmxLz7flDTH4FtI0SCqp0kjiM9l9EOXbApYGnJS8h20MH5yOH7fnwwbuNicDNrCTlkyi
        0392zqqJpHk/fTgHjiM+V1Q8AQTObwM=
Date:   Wed, 10 May 2023 16:00:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH] EDAC/amd64: Remove module version string
Message-ID: <20230510140007.GDZFujZ7R0Yw6cvkj2@fat_crate.local>
References: <20230410190959.3367528-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230410190959.3367528-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 10, 2023 at 02:09:59PM -0500, Yazen Ghannam wrote:
> The AMD64 EDAC module version information is not exposed through ABI
> like MODULE_VERSION(). Instead it is printed during module init.
> 
> Version numbers may be confusing in cases where module updates are
> partly backported resulting in a difference between upstream and
> backported module versions.
> 
> Remove the AMD64 EDAC module version information to avoid user
> confusion.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 4 +---
>  drivers/edac/amd64_edac.h | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
