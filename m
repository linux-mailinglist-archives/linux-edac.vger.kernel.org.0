Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09F937AB95
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhEKQPH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 12:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhEKQPG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 May 2021 12:15:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46997C061574;
        Tue, 11 May 2021 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=yoyxdL14+RHHBfspbtObR7ZjIkqw7Y80PNE65Db6waQ=; b=iJoE7tMXNcXRUeShByCFIzl/9M
        4dH5QpY7g+MAHQO1Unhr2TC25ienks2Wm/5X6ia+euxmQbuHhJDLjug3g9j9Ns4iDmagPf/fetzRv
        BugqwIzjfFCvKOuEIy8ZBYbf34GeTOeip3FyirFnBhvWmXsTEqI2j9dDiCChEnV+BZZoQ4PLyz/MZ
        02yRYrg80hcpUsjiWq1VaGxzi7HcrSW9mkVzi+MIm5m841BtY1XDqZywbVbGF5v/uTAfpyI3Rce/J
        AEtJ9DvgBKKYpau9oaZOoQQM7/eRIpjbJwaryizKftkg2UGrQQEZDr9Y84M2EUBIlKD1gFyCmQsg5
        R9XxB+fA==;
Received: from [2601:1c0:6280:3f0:d7c4:8ab4:31d7:f0ba]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgV1C-009kc9-1z; Tue, 11 May 2021 16:13:58 +0000
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
 <1bd2362b-9bbd-c813-e678-66119b53859f@infradead.org>
 <20210511154232.GA17213@aus-x-yghannam.amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ed4953c7-542e-7d57-7787-9bb53dad71b4@infradead.org>
Date:   Tue, 11 May 2021 09:13:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511154232.GA17213@aus-x-yghannam.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/11/21 8:42 AM, Yazen Ghannam wrote:
> On Fri, May 07, 2021 at 01:32:28PM -0700, Randy Dunlap wrote:
>> On 5/7/21 12:01 PM, Yazen Ghannam wrote:
>>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>>
>> ...
>>>
>>> Rome:
>>>   No interleaving
>>>   Nodes-per-Socket 0 (NPS0)
>>>   Nodes-per-Socket 1 (NPS1)
>>>   Nodes-per-Socket 2 (NPS2)
>>>   Nodes-per-Socket 4 (NPS4)
>>>   NPS2 w/o hashing
>>>   NPS4 w/o hashing
>>>
>>> Thanks,
>>> Yazen
>>
>> Hi Yazen,
>>
>> It appears that you need to provide a glossary of acronyms, e.g.:
>>
>> DF = (Data Fabric ?)
>> CS =
>> MCE =
>> NPS = Nodes per Socket
>> etc.
>>
>>
> 
> Hi Randy,
> 
> That's a good idea. Should it be in the cover letter, patches, or
> somewhere else?

Cover letter seems good to me.
Thanks.

-- 
~Randy

