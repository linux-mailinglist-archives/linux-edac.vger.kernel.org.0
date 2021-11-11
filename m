Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2AE44DB6B
	for <lists+linux-edac@lfdr.de>; Thu, 11 Nov 2021 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKKSIx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Nov 2021 13:08:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41344 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhKKSIx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 11 Nov 2021 13:08:53 -0500
Received: from zn.tnic (p200300ec2f0fc200f9f6db8f5ba53f04.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:c200:f9f6:db8f:5ba5:3f04])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86FD91EC0516;
        Thu, 11 Nov 2021 19:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636653962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JCc2yGR9ihcbHjSsyV2YI+8pjgQv2iAiqwBQ6/ZyWnw=;
        b=LunZFIpysoc0ShrDIyhOLYIlI8VWxczDxpvVSUyvXkCK+10ug+eH4F12t88ptXQmyQjh9J
        pAzb/kZwekyJ7yqbZHPRuV/zsSpgTufETMpYNrXlqLczY0r6zY8EcHNtCZ/5GUgAf2qyJW
        nz7B6c6cTuzbB/hqaUSf3uAy7Nx3890=
Date:   Thu, 11 Nov 2021 19:05:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 3/5] EDAC/amd64: Extend family ops functions
Message-ID: <YY1bg/ePwFjvmGaL@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-4-nchatrad@amd.com>
 <YYwFUYDl8wvO02wL@zn.tnic>
 <0006a641-44e7-5cf0-04e2-8c4499765b77@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0006a641-44e7-5cf0-04e2-8c4499765b77@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 11, 2021 at 09:53:32PM +0530, Chatradhi, Naveen Krishna wrote:
> Agreed, will create family_XXh_init() under per_family_init()'s switch.

No, you need to simply assign the per-family stuff in that one big
switch-case - no additional family_XXh_init() functions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
