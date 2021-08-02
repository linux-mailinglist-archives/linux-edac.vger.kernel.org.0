Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B773DD2CD
	for <lists+linux-edac@lfdr.de>; Mon,  2 Aug 2021 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhHBJTm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Aug 2021 05:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhHBJTm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 2 Aug 2021 05:19:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A32E604AC;
        Mon,  2 Aug 2021 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627895973;
        bh=29PlLx4+thAtabDg3X7ZcbW+1opEQwWBH6fLFAHy3Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCkyiEewi29jbnkIJdo/yqVWamGdF2Ka6tXJP0HHqwzWu3BVkM9jFVmZ7b9e1g5Vk
         wUW5y+tcdhWoBsSXOgPdxsrBTCjQC9HRrBb0dAdcCDMAg0SOIOX1dqCPHrD2rBJza3
         d0b1a9L/MS5oEU/pGCoQrj13H6RV9aUGQfT57dv3ETNLhdeBldMMjIOY5gygVwBs54
         czf9u3FT5HlECCXFj2by2ap70HaablB3zexjp8nJE9KbAs3VqoFG7ZJgzeFUbsZoPE
         ZExHSwF1Aon476OvHYsl5DFEYZ+q1jj4AGnr8p/4qYXa968ZYr2XyCr8nqzbLFI60/
         trO7kXNe2Pu2g==
Date:   Mon, 2 Aug 2021 11:19:27 +0200
From:   Robert Richter <rric@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YQe4n5H00g3xhSbQ@rric.localdomain>
References: <20210801143558.12674-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801143558.12674-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01.08.21 16:35:58, Len Baker wrote:

> @@ -1114,10 +1116,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			*p = '\0';
>  		} else {
>  			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> +				strscpy(p, OTHER_LABEL, left);
> +				left -= strlen(OTHER_LABEL);
>  				p += strlen(OTHER_LABEL);

Those both must be strlen(p) now as otherwise 'left' could underflow
(and p overflow).

-Robert

>  			}
> -			strcpy(p, dimm->label);
> +			strscpy(p, dimm->label, left);
> +			left -= strlen(p);
>  			p += strlen(p);
>  		}
> 
