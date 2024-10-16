Return-Path: <linux-edac+bounces-2107-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B49A0D23
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B60288311
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261B208963;
	Wed, 16 Oct 2024 14:46:21 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12782107A0;
	Wed, 16 Oct 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089981; cv=none; b=fPOj2sADqdmPV9nvJK1HR2NAK1SUGxO3bLlrLJ92HX0ZC8n1i9b1VR5984J8DQDZ+azU/jtizbzTi927D0TX4TP/zWcWRN45Z2h3Ulgz3GEfqsq0c60DxrFRnl5zIdPUM7jEZ/oad3I4UxcU1NABa9/+fr2zS7XO8MZgMrxN1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089981; c=relaxed/simple;
	bh=o49heouaeT3i9ORpupFQSWE9JQcRD6siSGczRW4Iiy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/JoLG7LbjlBSxivp5SMB/5o22CzkErN6sLlKYI2LNU5/XXPZNFfCkK8upQyXaBEogLzpTXzRk6Us7iXxicrw+ZI8sF14qtY7np3lpUYk0TtLz6lky11R0aandzb6Cy6j8Eavz6V1TYBKMkQiBVmdfXCIb+2q9lOejW75gNJuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273EA1007;
	Wed, 16 Oct 2024 07:46:49 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C949F3F71E;
	Wed, 16 Oct 2024 07:46:16 -0700 (PDT)
Message-ID: <1bd243ce-12d6-46d7-89d3-816fb58a4c95@arm.com>
Date: Wed, 16 Oct 2024 15:46:15 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 31/57] edac: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-31-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-31-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Borislav Petkov, Tony Luck

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Convert PAGES_TO_MiB() and MiB_TO_PAGES() to use the ternary operator so
> that they continue to work with boot-time page size; Boot-time page size
> can't be used with CPP because it's value is not known at compile time.
> For compile-time page size builds, the compiler will dead code strip for
> the same result.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  drivers/edac/edac_mc.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index 881b00eadf7a5..22132ee86e953 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -37,13 +37,12 @@
>  #include <linux/workqueue.h>
>  #include <linux/edac.h>
>  
> -#if PAGE_SHIFT < 20
> -#define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
> -#define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
> -#else				/* PAGE_SHIFT > 20 */
> -#define PAGES_TO_MiB(pages)	((pages) << (PAGE_SHIFT - 20))
> -#define MiB_TO_PAGES(mb)	((mb) >> (PAGE_SHIFT - 20))
> -#endif
> +#define PAGES_TO_MiB(pages)	(PAGE_SHIFT < 20 ?			\
> +					((pages) >> (20 - PAGE_SHIFT)) :\
> +					((pages) << (PAGE_SHIFT - 20)))
> +#define MiB_TO_PAGES(mb)	(PAGE_SHIFT < 20 ?			\
> +					((mb) << (20 - PAGE_SHIFT)) :	\
> +					((mb) >> (PAGE_SHIFT - 20)))
>  
>  #define edac_printk(level, prefix, fmt, arg...) \
>  	printk(level "EDAC " prefix ": " fmt, ##arg)


