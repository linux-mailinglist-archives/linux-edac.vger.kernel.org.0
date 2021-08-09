Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87D13E4953
	for <lists+linux-edac@lfdr.de>; Mon,  9 Aug 2021 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhHIP5G (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Aug 2021 11:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235525AbhHIP5F (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Aug 2021 11:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628524604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksirypdUbDyon7gnRT9jI8jlCatrBjNvokJRvHrhIUA=;
        b=KwlGZlc7vXPTVgJtqUUgFB1DGjz2EuC5iuDYYiaJLfYUjet4/bcmPqhNj9sT2m664kvBdQ
        eIS0fLdRXP6ZhDYST25lk7puwkWqrJpfcJqVLgae2L2teghPQpcUys9xaMe/3vzAUCUmwx
        bgV4sfbkPUDokyvXb0zv/lhoUNyrfSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-LyXmDG6AO1aeto5S1r0Jzg-1; Mon, 09 Aug 2021 11:56:43 -0400
X-MC-Unique: LyXmDG6AO1aeto5S1r0Jzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE4108799EC;
        Mon,  9 Aug 2021 15:56:41 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AB5A5DA60;
        Mon,  9 Aug 2021 15:56:41 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     dan.j.williams@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-edac@vger.kernel.org>,
        <x86@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] x86/pat: pass correct address to sanitize_phys
References: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 09 Aug 2021 11:58:05 -0400
In-Reply-To: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Wed, 21 Jul 2021 15:48:10 -0400")
Message-ID: <x494kbyehki.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Ping?  This patch fixes a real problem seen in the field.  Can I get
some review?

Thanks!
Jeff

Jeff Moyer <jmoyer@redhat.com> writes:

> memtype_reserve takes an address range of the form [start, end).  It
> then passes the start and end addresses to sanitize_phys, which is meant
> to operate on the inclusive addresses.  If end falls at the end of the
> physical address space, sanitize_phys will return 0.  This can result in
> drivers failing to load:
>
> [   10.000087] mpt3sas_cm0: unable to map adapter memory! or resource not found
> [   10.000334] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10597/_scsih_probe()!
>
> Fix this by passing the inclusive end address to sanitize_phys.
>
> Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for "decoy" addresses")
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> --
> It might be worth adding a comment, here.  If there are any suggestions
> on what a sane wording would be, I'm all ears.
>
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 3112ca7786ed..482557905294 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -583,7 +583,7 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>  	int err = 0;
>  
>  	start = sanitize_phys(start);
> -	end = sanitize_phys(end);
> +	end = sanitize_phys(end - 1) + 1;
>  	if (start >= end) {
>  		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
>  				start, end - 1, cattr_name(req_type));

