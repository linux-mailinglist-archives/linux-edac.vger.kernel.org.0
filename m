Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06075154482
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2020 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBFNFd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Feb 2020 08:05:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbgBFNFd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Feb 2020 08:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580994332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VK0cVU+EaUKEqVdhJY86wR9NaSgWi1ZgRcL6h4AgQY4=;
        b=RJVyhYJyFOjEcAmSku0BmdDwKmhozGSaMPqC7IQyoeNSBkorAqK2n6jb/awmC3vkRA6bL1
        B0l3+5c3Jb9xb/IrG9izaRJRXoRZ4Omq1AyUtFQ9zSXfdJc+WBj6I6hmxPJttxL/rOCY0u
        UxbRnogZhGSWrvTbh5AREplNaz7jIYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-RZYZ0dpDMyOQPkIOfvJQLw-1; Thu, 06 Feb 2020 08:05:27 -0500
X-MC-Unique: RZYZ0dpDMyOQPkIOfvJQLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D5E763AD8;
        Thu,  6 Feb 2020 13:05:26 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32EEC863A5;
        Thu,  6 Feb 2020 13:05:25 +0000 (UTC)
Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
From:   Prarit Bhargava <prarit@redhat.com>
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
 <1f3f5f54-eb31-1e2a-27be-7ed4cb3dc2d3@redhat.com>
Message-ID: <e4088217-78cc-91f5-fcc9-6152aaf12caf@redhat.com>
Date:   Thu, 6 Feb 2020 08:05:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1f3f5f54-eb31-1e2a-27be-7ed4cb3dc2d3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/6/20 7:53 AM, Prarit Bhargava wrote:
> 
> 
> On 2/6/20 6:10 AM, Borislav Petkov wrote:
>> On Wed, Feb 05, 2020 at 07:58:31AM -0500, Prarit Bhargava wrote:
>>
>>> Subject: Re: [PATCH] x86/mce: Enable HSD131, HSM142, HSW131, BDM48, and HSM142
>>
>> That subject is unreadable for humans.
> 
> Yeah :/  I couldn't think of a better one.  Maybe "Block spurious corrected
> errors on some Intel processors"?  Any other suggestion?
> 
>>
>>> Intel Errata HSD131, HSM142, HSW131, and BDM48 report that
>>> "spurious corrected errors may be logged in the IA32_MC0_STATUS register
>>> with the valid field (bit 63) set, the uncorrected error field (bit 61)
>>> not set, a Model Specific Error Code (bits [31:16]) of 0x000F, and
>>> an MCA Error Code (bits [15:0]) of 0x0005."
>>>
>>> Block these spurious errors from the console and logs.
>>
>> Are they being hit in the wild or why do we need this?
> 
> Alexander, cc'd, is being hit by this in the wild.
> 
>>
>>> Links to Intel Specification updates:
>>> HSD131: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-desktop-specification-update.html
>>> HSM142: https://www.intel.com/content/www/us/en/products/docs/processors/core/4th-gen-core-family-mobile-specification-update.html
>>> HSW131: https://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200v3-spec-update.html
>>> BDM48: https://www.intel.com/content/www/us/en/products/docs/processors/core/5th-gen-core-family-spec-update.html
>>
>> Those links tend to get stale with time. If you really want to refer to
>> the PDFs, add a new bugzilla entry on https://bugzilla.kernel.org/, add
>> them there as an attachment and add the link to the entry to the commit
>> message.
>>
>>> Signed-off-by: Alexander Krupp <centos@akr.yagii.de>
>>
>> What's that Signed-off-by: tag supposed to mean?

Sorry.  I missed this question, but I really don't understand the question.
Alexander posted a patch in a kernel bugzilla @ Red Hat and I modified the patch
with some additional changes.  I don't want him to lose credit for the work so
he's got a proper Signed-off-by tag for this patch.

P.

