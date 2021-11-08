Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73792448055
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhKHNkZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 08:40:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43176 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhKHNkZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:25 -0500
Received: from zn.tnic (p200300ec2f33110093973d8dfcf40fd9.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:9397:3d8d:fcf4:fd9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F6D31EC0295;
        Mon,  8 Nov 2021 14:37:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636378660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n3RZpo1ny/8yHy++KCnVcsXaUMiSac3etAKckHaenK8=;
        b=gpAQW+Cfn0/lGTfBOMw0TRx6nfeGM+oWsZu6DPimsVxwOyy+ZgxeTbR1PwEPGIoip+40LW
        BrTWkBRdZ5pLm7DaYb+3VTTCWluKWE78GIB3Tlj1gdGUlwqN5cU/8JTsEOfYlFnVZbWhev
        Rhk3Z1BNBzIB7OlvCzULYFHCzOwAi5s=
Date:   Mon, 8 Nov 2021 14:37:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 2/5] EDAC/mce_amd: Extract node id from MCA_IPID
Message-ID: <YYkoIjBV/RaitMH+@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-3-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028130106.15701-3-nchatrad@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 28, 2021 at 06:31:03PM +0530, Naveen Krishna Chatradhi wrote:
> On SMCA banks of the GPU nodes, the node id information is
> available in register MCA_IPID[47:44](InstanceIdHi).
> 
> Convert the hardware node ID to a value used by Linux
> where GPU nodes are sequencially after the CPU nodes.

"sequentially"

Use a spellchecker when writing commit messages pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
