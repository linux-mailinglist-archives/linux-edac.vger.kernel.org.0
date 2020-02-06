Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685DE15444B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2020 13:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBFMxo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Feb 2020 07:53:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727613AbgBFMxo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Feb 2020 07:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580993623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R41SlG6aMHK5jXUAarbhZUQ8sA4pF1/4Q8fbxyhZMA4=;
        b=YZCTWV640cA7Drsd7QSa8ADgmskNp/vvFAKWLj8ZRJPpqsc2b29dJkR5f+BEa47YV4pO4F
        XE4lRQ0nBqfN5FQb04/wxQ06xD7u92mOoP4vRR1urSqe3KD6dEw09nfgsfcK6QvF3SqqmN
        bAPC77bnzLWlcoEpZKEQNMDG9UteFio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-jjCyA0VZN5WkV74i1r8WRg-1; Thu, 06 Feb 2020 07:53:38 -0500
X-MC-Unique: jjCyA0VZN5WkV74i1r8WRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F52108838F;
        Thu,  6 Feb 2020 12:53:36 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BEA427060;
        Thu,  6 Feb 2020 12:53:35 +0000 (UTC)
Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
References: <20200205125831.20430-1-prarit@redhat.com>
 <20200206110811.GC9741@zn.tnic>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <1f3f5f54-eb31-1e2a-27be-7ed4cb3dc2d3@redhat.com>
Date:   Thu, 6 Feb 2020 07:53:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200206110811.GC9741@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/6/20 6:10 AM, Borislav Petkov wrote:
> On Wed, Feb 05, 2020 at 07:58:31AM -0500, Prarit Bhargava wrote:
> 
>> Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
> 
> That subject is unreadable for humans.

Yeah :/  I couldn't think of a better one.  Maybe "Block spurious corrected
errors on some Intel processors"?  Any other suggestion?

> 
>> Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
>> "spurious corrected errors may be logged in the IA32_MC0_STATUS register
>> with the valid field (bit 63) set, the uncorrected error field (bit 61)
>> not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
>> an MCA Error Code (bits [15:0]) of 0x0005."
>>
>> Block these spurious errors from the console and logs.
> 
> Are they being hit in the wild or why do we need this?

Alexander, cc'd, is being hit by this in the wild.

> 
>> Links to Intel Specification updates:
>> HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-desktop-specification-update.html
>> HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-mobile-specification-update.html
>> HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v3-spec-update.html
>> BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/core/5th-gen-core-family-spec-update.html
> 
> Those links tend to get stale with time. If you really want to refer to
> the PDFs, add a new bugzilla entry on https://bugzilla.kernel.org/, add
> them there as an attachment and add the link to the entry to the commit
> message.
> 
>> Signed-off-by: Alexander Krupp <centos@akr.yagii.de>
> 
> What's that Signed-off-by: tag supposed to mean?
> 
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: linux-edac@vger.kernel.org
>> ---
>>  arch/x86/kernel/cpu/mce/core.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
> 
> If at all, this should be done by adding an intel_filter_mce() function
> and called from filter_mce() so that such errors don't get logged.

I'll take a look over there.

P.

> 
> Thx.
> 

