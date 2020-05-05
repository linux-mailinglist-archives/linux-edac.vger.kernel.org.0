Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD881C5C90
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 17:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgEEPu5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 11:50:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730442AbgEEPu4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 11:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588693856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BU5ZQpCj0l/68xgDkpfBCKuLh4I4hSUfny0CTG25x9g=;
        b=ShsQrqC4GGdrmvHI4Z9exrLb7/W+txvUYl0Yylx3s1K1me03IZSazY/WBhAnfCurBynjn2
        fmaR5SnEZuLFlPZSrLCfRyAMWEF8yDSeqlmvs8VImnlr6Dtd0VPUV223Of/zdh6XBbKixJ
        ncV7QYNob+cB3wDjh1uJm4DTq8W0SqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-OGdSBiARP6-UJlOyuB7bbA-1; Tue, 05 May 2020 11:50:50 -0400
X-MC-Unique: OGdSBiARP6-UJlOyuB7bbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64DD84E27B;
        Tue,  5 May 2020 15:50:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-81.rdu2.redhat.com [10.10.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A96775D9DA;
        Tue,  5 May 2020 15:50:45 +0000 (UTC)
Subject: Re: [PATCH] doc: Fix some typo errors in ras.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200505151049.11134-1-longman@redhat.com>
 <20200505093258.77d052f5@lwn.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2cb38bb2-bdb5-5fea-870a-ec92401ea374@redhat.com>
Date:   Tue, 5 May 2020 11:50:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200505093258.77d052f5@lwn.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/5/20 11:32 AM, Jonathan Corbet wrote:
> On Tue,  5 May 2020 11:10:49 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> Fix typo errors.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/ras.rst | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
>> index 0310db624964..8b1803b2606f 100644
>> --- a/Documentation/admin-guide/ras.rst
>> +++ b/Documentation/admin-guide/ras.rst
>> @@ -156,10 +156,10 @@ the labels provided by the BIOS won't match the real ones.
>>   ECC memory
>>   ----------
>>   
>> -As mentioned on the previous section, ECC memory has extra bits to be
>> -used for error correction. So, on 64 bit systems, a memory module
>> -has 64 bits of *data width*, and 74 bits of *total width*. So, there are
>> -8 bits extra bits to be used for the error detection and correction
>> +As mentioned on the previous section, ECC memory has extra bits to
>> +be used for error correction. So, on 64 bit systems, a memory module
>> +has 64 bits of *data width*, and 72 bits of *total width*. So, there
>> +are 8 extra bits to be used for the error detection and correction
>>   mechanisms. Those extra bits are called *syndrome*\ [#f1]_\ [#f2]_.
> So I had to work to figure out what the change was, since you didn't say
> in the changelog and you refilled the paragraph.  But this looks like a
> *factual* error, giving the wrong number of bits, right?  It seems like
> the changelog should say that.  Do the people who know about this stuff
> agree that the change is correct?
>
> Thanks,
>
> jon
>
Yes, I change 74 bits to 72 bits and remove an extra "bits". Will send 
out v2 to clarify that.

Thanks,
Longman

