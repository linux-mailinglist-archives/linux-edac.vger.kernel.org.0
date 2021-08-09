Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980703E4392
	for <lists+linux-edac@lfdr.de>; Mon,  9 Aug 2021 12:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhHIKFc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Aug 2021 06:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234822AbhHIKF3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Aug 2021 06:05:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAF4861004;
        Mon,  9 Aug 2021 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628503509;
        bh=2zKz1qElSq58PZRYESvVVX02YG+iPBjCI2bz6gw0UN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkLPUzp3FVZI0suGivgvscOU4H5YH5WZAOm7D/zYqm8djWcyc4CaPbrBs5EQiHzi6
         Svp6jbyK7pZaVKk5NSlSX/mgyVfAKzvDN5SnlF6Pza1YVkgGZLpWHPKRcLF00uEuWR
         FyvkpnJWfTghbe/BfclSMxIcqKantX3oTZakzcsa1ZPxg8/2FPwIoSZVNkKde4CHqR
         zo4Kd3fIrtdmi6dIkCvh1Zwinfv2H+dOb7rm4w9qHQJvMVVQjgmSwPEpb+G4m1Gd55
         lS3Gfso+iprAft7mx7Ywk1WJ77XTsMQmV6Jlg1f6yoGULS0odQBO9hDrorA4JHhxrb
         20UyaqFPA+Kig==
Date:   Mon, 9 Aug 2021 12:05:04 +0200
From:   Robert Richter <rric@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Joe Perches <joe@perches.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YRD90L6PMoVbbv+9@rric.localdomain>
References: <20210807155957.10069-1-len.baker@gmx.com>
 <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
 <20210808112617.GA1927@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808112617.GA1927@titan>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 08.08.21 13:26:17, Len Baker wrote:

> > Perhaps this should use scnprintf rather than strscpy
> > Something like:
> > 			n += scnprintf(buf + n, len - n, "%s",
> > 				       p == e->label ? dim->label : OTHER_LABEL);
> >
> In the first version [1] the scnprintf was used but Robert Richter don't
> see any benefit compared with the current implementation.
> 
> [1] https://lore.kernel.org/linux-hardening/20210725162954.9861-1-len.baker@gmx.com/

Reason is that there is the assumption that p must always point at the
end of the string and its trailing zero byte. I am not opposed using
the string function's return code instead of strlen() to get the
length. But why using formated output if strscpy() can be used?

-Robert
