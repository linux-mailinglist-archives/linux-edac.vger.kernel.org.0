Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF02FAA3F
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jan 2021 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394034AbhARTcJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jan 2021 14:32:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41920 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388748AbhARTcC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 18 Jan 2021 14:32:02 -0500
Received: from zn.tnic (p200300ec2f069f001e13c6b7481d9a7b.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9f00:1e13:c6b7:481d:9a7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BED21EC04F0;
        Mon, 18 Jan 2021 20:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610998279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=csxJ+kKfOHvSmWehXaT4nqOQ0sXQwmYUqvongsXK0Mw=;
        b=kA8Vvw/14/dFp9iV53pBm0bdIOX5XqJj5N2yz9wnuB52cPI8Z/eT+z/V92DNiDK8fqKb7B
        9gOCN5h47+G16ZToyBYMLNgXHEgHTxckqaHyFbMlvWATsYzSlITAupnsAnuF9g54SHnwDX
        5rL8DjJ5zbDIGysOvYei0uqj7tCv/jI=
Date:   Mon, 18 Jan 2021 20:31:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, wgh@torlan.ru
Subject: Re: [PATCH] EDAC/AMD64: Update scrub register addresses for newer
 models
Message-ID: <20210118193112.GF30090@zn.tnic>
References: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jan 16, 2021 at 02:33:53PM +0000, Yazen Ghannam wrote:
> +static struct {
> +	u32 base, limit;
> +} f17h_scrub_regs = {F17H_M30H_SCR_BASE_ADDR, F17H_M30H_SCR_LIMIT_ADDR};

Why not make this part of struct amd64_umc so that you can access them
through pvt->umc?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
