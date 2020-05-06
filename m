Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5C1C7627
	for <lists+linux-edac@lfdr.de>; Wed,  6 May 2020 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgEFQVv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 May 2020 12:21:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25716 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729992AbgEFQVv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 May 2020 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588782110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5Nue4CqT9GXVjnCIT8OHUF4iLM5gQKu+kez1QsHUog=;
        b=Axl7Tit4OEE47sRdsvtqDzDjKHo8h2CMDGeK3TePCXNWKXkW3mxAgF5X2XNUOk3CshivVd
        sGk1F+tLfC7YA7GsGVoweQFgPTwFA6O+lm249OZ9c0yYwl56q4DWt6x371yNEJIk0YUsp+
        T3Wmgi0VRhnCisW8TxYXgAfI9wV7qKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-LS8u2htgPimpJkvK9uyYxQ-1; Wed, 06 May 2020 12:21:48 -0400
X-MC-Unique: LS8u2htgPimpJkvK9uyYxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2946F107B768;
        Wed,  6 May 2020 16:21:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-141.rdu2.redhat.com [10.10.116.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E585B690E2;
        Wed,  6 May 2020 16:21:44 +0000 (UTC)
Subject: Re: [PATCH] doc: Fix some typo errors in ras.rst
To:     Borislav Petkov <bp@alien8.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200505151049.11134-1-longman@redhat.com>
 <20200505154816.GH16070@bombadil.infradead.org>
 <20200505160308.GA25446@zn.tnic>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eaf7072f-16a8-7202-9c47-606afca7433c@redhat.com>
Date:   Wed, 6 May 2020 12:21:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200505160308.GA25446@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/5/20 12:03 PM, Borislav Petkov wrote:
> On Tue, May 05, 2020 at 08:48:16AM -0700, Matthew Wilcox wrote:
>> Usually a 64-bit system refers to the width of a pointer.  Here, it's
>> referring to the width of the memory system, which is rather confusing.
>> How about "In the above example" instead of "So, on 64 bit systems".
> Yes, that should not talk about 64-bit systems but about the length of
> the word the memory controller uses to create the ECC check bits out of.
>
> That whole doc needs checking/fixing.

I am not knowledgeable enough to check/fix the whole document. This 
patch is motivated primarily by the incorrect "74 bits" total width that 
I saw. I will send a v2 to make the suggested edit. I will leave it to 
you to do the full document check.

Cheers,
Longman

