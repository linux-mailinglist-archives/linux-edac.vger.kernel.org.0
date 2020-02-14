Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6515F8B8
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2020 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgBNV37 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Feb 2020 16:29:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25314 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387958AbgBNV36 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 14 Feb 2020 16:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581715798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kzi89iF04QxCLMnFCGjJjn2+0t6DNJ4N+OMGiy9A90U=;
        b=LsNXEtgpqo7FZH9H4siB/uCmPVhtY/nLNwXvhsaA7GPD6OPd9Q+d2M4jU5nUyRiyYDxGj8
        qH+/DMAG6AE1JgaPVvbGCt8F9fI/G5hiaXwRSg0sZEe6kVtmaWxYfDnM/3sy6nrwAryonh
        uDTfOpjIs4m3hKg6ygZEgO1VJ+WSGVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-sW6XycnXOlCOwyWhijM0uQ-1; Fri, 14 Feb 2020 16:29:54 -0500
X-MC-Unique: sW6XycnXOlCOwyWhijM0uQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CDE51005510;
        Fri, 14 Feb 2020 21:29:52 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB6B05C1C3;
        Fri, 14 Feb 2020 21:29:50 +0000 (UTC)
Subject: Re: [PATCH] x86/mce: Do not log spurious corrected mce errors
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
References: <20200214123407.4184-1-prarit@redhat.com>
 <20200214173644.GA7913@agluck-desk2.amr.corp.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <0adb58a9-45d4-85c0-f3b3-517a19d2534e@redhat.com>
Date:   Fri, 14 Feb 2020 16:29:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200214173644.GA7913@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/14/20 12:36 PM, Luck, Tony wrote:
> On Fri, Feb 14, 2020 at 07:34:07AM -0500, Prarit Bhargava wrote:
>>  #ifdef CONFIG_X86_MCE_AMD
>>  extern bool amd_filter_mce(struct mce *m);
>> +extern bool intel_filter_mce(struct mce *m);
>>  #else
> 
> Something very weird is going on here. Why does
> CONFIG_X86_MCE_AMD have to be set to enable some
> *Intel* filter operation?

That's a mistake.  I'll fix that in v2.

P.

> 
> -Tony
> 

