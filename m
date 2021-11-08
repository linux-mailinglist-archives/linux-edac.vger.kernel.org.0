Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35265449C25
	for <lists+linux-edac@lfdr.de>; Mon,  8 Nov 2021 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhKHTGp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Nov 2021 14:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbhKHTGp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Nov 2021 14:06:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B12C061570;
        Mon,  8 Nov 2021 11:04:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f3311008f2ddbd2a2570897.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8f2d:dbd2:a257:897])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 419B11EC0464;
        Mon,  8 Nov 2021 20:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636398239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jc0gwrahbUXBGchzSO7YMn73+H6g1iIZAuk0kz/EYx4=;
        b=NxnDcgn5oT1vJj38T1+RGdJfzW4jyS1l3CmUXM8Vt8sTzSjSjdUOCKNptUiIt4eTWj48fd
        PbXz7i3SCBsYzz3xbyakXQ5N1bi56w7CYB6DLwWgVX3sH1KknlQ3PxbLIcFJkSNFxBVRMR
        2UhQOK8mIDhlXnKjWqoKjTLmfwXrw50=
Date:   Mon, 8 Nov 2021 20:03:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YYl0l+XV/QRZieGY@zn.tnic>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-2-nchatrad@amd.com>
 <YYF9ei59G/OUyZqR@zn.tnic>
 <b7f3639a-e46c-25e8-270b-04860074fd3c@amd.com>
 <YYknXBpOUQtV1aZ8@zn.tnic>
 <bcf5e86c-d3f1-0dab-2bed-505b1eb95f17@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcf5e86c-d3f1-0dab-2bed-505b1eb95f17@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 08, 2021 at 10:23:49PM +0530, Chatradhi, Naveen Krishna wrote:
> Northbridges on CPUs and GPUs can be described using the elements in the
> above structure.

If you're going to describe *northbridges*, then your struct cannot be called
system_topology...

> I thought organizing the data in a structure would simplify the
> initialization of cpus and gpus.

Ehh, did you even read my mail where I tried to explain that sprinkling

	if (gpu)
		this
	else 
		that

all over amd_cache_northbridges() is not proper design?

;-\

> I will modify the  patch to enumerate gpu northbridge info only if there are
> 
> gpu nodes with  pci_device to access the node_map registers.

Why would you do that? What's the advantage?

How about you answer my questions first so that we agree on the design
first before you go and do things?

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
