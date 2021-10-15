Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7054742FC0D
	for <lists+linux-edac@lfdr.de>; Fri, 15 Oct 2021 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbhJOT2L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Oct 2021 15:28:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39968 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242721AbhJOT2B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 15 Oct 2021 15:28:01 -0400
Received: from zn.tnic (p200300ec2f0cfb00bb7b1559c428a59f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fb00:bb7b:1559:c428:a59f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB41F1EC051F;
        Fri, 15 Oct 2021 21:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634325952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=diUPBadghGnVRGSh80f0o42e9M3rUKFPPTqan9vhLOA=;
        b=Aa967DoR7YNNJtpW+XvIMGckgMIqnKf5WypS+n71Jwi1W4jKxEmlyo5W21VMfikUR5xxfp
        d4PG0ZhQrn9nDqP5swC0wLWgkj8ffB6PJQjCUUDyevOfcDTDo9/z46DsAb1RgF0tN6Vtwu
        7YvMzKQb0AgVYdBUff+P9WyENt/4qW4=
Date:   Fri, 15 Oct 2021 21:25:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com
Subject: Re: [PATCH v4 0/4] x86/edac/amd64: Add support for noncpu nodes
Message-ID: <YWnVvgluSC03Z1mg@zn.tnic>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
 <YWiKpw5MwtAiwNyB@zn.tnic>
 <9f78573d-c969-da1d-8a7d-4abd7d8a75f2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f78573d-c969-da1d-8a7d-4abd7d8a75f2@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 15, 2021 at 05:48:32PM +0530, Chatradhi, Naveen Krishna wrote:
> Could you please review the latest one (above link)

Ok.
 
> or should i push them as v5, to avoid the confusion.

Nah, not necessary.

The goal is to always avoid spamming maintainers with patchsets if not
absolutely necessary. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
