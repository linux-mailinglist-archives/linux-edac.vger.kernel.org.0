Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6F8246388
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHQJjR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgHQJjQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Aug 2020 05:39:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE960C061389;
        Mon, 17 Aug 2020 02:39:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be0071e1cf3fa1f5ba15.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:71e1:cf3f:a1f5:ba15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EAF351EC026E;
        Mon, 17 Aug 2020 11:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597657153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kerY6UuNjXm1hwTwGO5SuB4V2uIj2IdiaMTag7jys8g=;
        b=iReEib+xDNEQKjK0ewRzbuhGXnQanqOQnzkd0tfZoAkZUZvDQkjM55JR8YterhkDT7RJ3l
        vbORbauwl3AFlhkA1i+aOl5NSkju5kXG1kwEvIx2N39Bh+iIj6C3GgjYC9d+1FlkO97Ncn
        1Y89ZkVLvqy2kP81d49OmQdS4inDvpQ=
Date:   Mon, 17 Aug 2020 11:40:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/MCE/AMD, EDAC/mce_amd: Remove struct
 smca_hwid.xec_bitmap
Message-ID: <20200817093956.GC549@zn.tnic>
References: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 20, 2020 at 02:53:53PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The Extended Error Code Bitmap (xec_bitmap) for a Scalable MCA bank type
> was intended to be used by the kernel to filter out invalid error codes
> on a system. However, this is unnecessary because the hardware will only
> report valid error codes.

That's a kinda bold statement. :)

Are you saying, you wanna trust verification and that check is totally
useless?

Or is there another reason for removing it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
