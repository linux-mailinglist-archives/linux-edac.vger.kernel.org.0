Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85886298B84
	for <lists+linux-edac@lfdr.de>; Mon, 26 Oct 2020 12:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773221AbgJZLLx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Oct 2020 07:11:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35692 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773194AbgJZLLh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Oct 2020 07:11:37 -0400
Received: from zn.tnic (p200300ec2f07cc003725ac6034898aff.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:cc00:3725:ac60:3489:8aff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 604D11EC0299;
        Mon, 26 Oct 2020 12:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603710694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h6H9IyipOfafFZkUPerdfTU6T6boaJdO4lhf1zJq2SI=;
        b=hkjV8i72yVGZgawKyvtovQkU7hR2/BUf+rBJ4HClnaQDc73zcUfZjL312tx/eFHpsFBj8j
        bVa2kz0PEZX8HIqu2knHsNUcU2rnyQ4wnqGs76SLFLlHxWYijZ2W9Rc0sdy6AVQL+BUIAT
        vhownORCnh6wA7nrF236XqtfbRaHMXU=
Date:   Mon, 26 Oct 2020 12:11:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     trix@redhat.com
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac: amd64_edac: remove unneeded break
Message-ID: <20201026111125.GB22116@zn.tnic>
References: <20201019193524.13391-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019193524.13391-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 19, 2020 at 12:35:24PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/edac/amd64_edac.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
