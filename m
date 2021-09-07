Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE63C4027A9
	for <lists+linux-edac@lfdr.de>; Tue,  7 Sep 2021 13:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbhIGLSQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Sep 2021 07:18:16 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39196
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244318AbhIGLSP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Sep 2021 07:18:15 -0400
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8ABB03F101;
        Tue,  7 Sep 2021 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631013427;
        bh=RD8ImtiPR0GJEKbytD1cXq/JGVHkX77jtTDQ9RdUdig=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=BTyYN2scPJVZWS/wrFi7/rvxH6QuisHSrmd+mLBL40ED+bhgVPYGkJWZ6huXm2mU4
         NjJY9Ae5WyptAJT7wBIb6qDKU5fEyOtfrpZLykJAS4VR+eN2INEY5cVbvzs6zi86vs
         PnLdDOFW0PBn58tiSv0zDA993szwr3YyX3RwqEIM2kicml4+LK8hMmgoAzKrtmOCRk
         4s5iLz9TFOXT5tE9DWM+6McaV6y1c+FHy5+GjgMPvrdTwwxYmaeUtqXPZo9jB0SKfm
         WDWF7emCz+cp+Dw1ZfRHzcMTXcTyQqSaiPohu2QZ8UmJwcvA5ALYRLkigP9PFt+ODL
         5hzssrogdfP0g==
Subject: NACK: [PATCH] EDAC/device: Remove redundant initialization of pointer
 dev_ctl
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210907105913.15077-1-colin.king@canonical.com>
 <YTdI98H5yF55fYsC@zn.tnic>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <14b02aa7-178b-2a03-afeb-a4c7be56d84f@canonical.com>
Date:   Tue, 7 Sep 2021 12:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTdI98H5yF55fYsC@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 07/09/2021 12:11, Borislav Petkov wrote:
> On Tue, Sep 07, 2021 at 11:59:13AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The variable dev_ctl is being initialized with a value that is never
>> read, it is being updated later on. The assignment is redundant and
>> can be removed.
>>
>> Addresses-Coverity: ("Unused value")
> 
> I'll never get a public reference to what those things mean, will I?
> 
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/edac/edac_device.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index 8c4d947fb848..a337f7afc3b9 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>> @@ -75,7 +75,6 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
>>  	 * provide if we could simply hardcode everything into a single struct.
>>  	 */
>>  	p = NULL;
>> -	dev_ctl = edac_align_ptr(&p, sizeof(*dev_ctl), 1);
> 
> Are you absolutely sure this function doesn't have any side-effects,
> say, to &p and removing the call would break the pointer offsets for the
> one-shot allocation?

Oops. brown-paper-bag on head. It does alter p. NACK.

> 

