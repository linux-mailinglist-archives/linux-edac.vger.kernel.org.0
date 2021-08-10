Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC043E838A
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 21:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhHJTVW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 15:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhHJTVW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 15:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628623259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKz5RODz5prskKuvBZqrHvPYmgz3FaALdg2u0GEXeAk=;
        b=JCicweRCzxha6Q7q8a7rp0c29YjhSFVTzc7ezJ4NP5QRKRnOwavf9hQm3t7mPWp252LTur
        ymdIIwtp9mVsbzTqrfjoPfcnQR5k1mYq/lFZ7K0248ky4RiUuyDWam0f7vIJVHQpPNcSHl
        ntCQUsPMTDtVztqBiRo4PJvOIPuPa0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-zMfGCzHEMwWOtYJbUDazOA-1; Tue, 10 Aug 2021 15:20:58 -0400
X-MC-Unique: zMfGCzHEMwWOtYJbUDazOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34E05190B2A0;
        Tue, 10 Aug 2021 19:20:56 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B4905C1A1;
        Tue, 10 Aug 2021 19:20:54 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     dan.j.williams@intel.com, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] x86/pat: pass correct address to sanitize_phys
References: <x49tuknmosl.fsf@segfault.boston.devel.redhat.com>
        <87wnotst1l.ffs@tglx>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 10 Aug 2021 15:22:19 -0400
In-Reply-To: <87wnotst1l.ffs@tglx> (Thomas Gleixner's message of "Tue, 10 Aug
        2021 08:38:46 +0200")
Message-ID: <x49k0ktm7f8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Jeff,
>
> On Wed, Jul 21 2021 at 15:48, Jeff Moyer wrote:
>
> Please write function names with brackets, i.e. sanitize_phys().

OK, will do.

>> memtype_reserve takes an address range of the form [start, end).  It
>
> [start, end]

Start is inclusive, end is exclusive, so start <= x < end.  I used the
notation found here:

  https://en.wikipedia.org/wiki/Interval_(mathematics)

If that's too confusing, I can stick to inclusive vs exclusive verbiage.

>> then passes the start and end addresses to sanitize_phys, which is meant
>> to operate on the inclusive addresses.  If end falls at the end of the
>> physical address space, sanitize_phys will return 0.  This can result in
>> drivers failing to load:
>>
>> [   10.000087] mpt3sas_cm0: unable to map adapter memory! or resource not found
>> [   10.000334] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10597/_scsih_probe()!
>
> Doesn't this trigger the WARN() right below that offending line?

It does.  I'll include the warning message in the v2 posting.

>> Fix this by passing the inclusive end address to sanitize_phys.
>>
>> Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for "decoy" addresses")
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> --
>> It might be worth adding a comment, here.  If there are any suggestions
>> on what a sane wording would be, I'm all ears.
>
> See below.
>
>> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
>> index 3112ca7786ed..482557905294 100644
>> --- a/arch/x86/mm/pat/memtype.c
>> +++ b/arch/x86/mm/pat/memtype.c
>> @@ -583,7 +583,7 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>>  	int err = 0;
>>  
>>  	start = sanitize_phys(start);
>> -	end = sanitize_phys(end);
>
>         /*
>          * [start, end] is an exclusive address range, but
>          * sanitize_phys() expects an inclusive end address
>          */

That works for me (modulo the interval notation), thanks for the
suggestion.

Thanks!
Jeff

