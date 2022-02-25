Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082A44C4861
	for <lists+linux-edac@lfdr.de>; Fri, 25 Feb 2022 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiBYPNW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 25 Feb 2022 10:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiBYPNV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Feb 2022 10:13:21 -0500
Received: from eos.fwall.u-szeged.hu (eos.fwall.u-szeged.hu [160.114.120.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ED423BD7
        for <linux-edac@vger.kernel.org>; Fri, 25 Feb 2022 07:12:47 -0800 (PST)
Received: from esym.intra ([192.168.105.4] helo=esym.fwall.u-szeged.hu)
        by eos.fwall.u-szeged.hu with esmtp (Exim 4.94.2)
        (envelope-from <tibor.gyori@chem.u-szeged.hu>)
        id 1nNcGp-00GWRV-3e; Fri, 25 Feb 2022 16:12:35 +0100
X-AuditID: a07278f7-421bd7000000255f-5e-6218f1e22856
Received: from eos.fwall.u-szeged.hu (eos.intra [192.168.105.3])
        by esym.fwall.u-szeged.hu (Symantec Messaging Gateway) with SMTP id F4.25.09567.2E1F8126; Fri, 25 Feb 2022 16:12:34 +0100 (CET)
Received: from sol.cc.u-szeged.hu ([160.114.8.24])
        by eos.fwall.u-szeged.hu with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <tibor.gyori@chem.u-szeged.hu>)
        id 1nNcGn-00GWRQ-3a; Fri, 25 Feb 2022 16:12:34 +0100
Received: from apache by sol.cc.u-szeged.hu with local (Exim 4.80.1)
        (envelope-from <tibor.gyori@chem.u-szeged.hu>)
        id 1nNcGo-0002Xl-I2; Fri, 25 Feb 2022 16:12:34 +0100
Received: from BC9CE9E9.catv.pool.telekom.hu (BC9CE9E9.catv.pool.telekom.hu
 [188.156.233.233]) by webmail.u-szeged.hu (Horde Framework) with HTTP; Fri,
 25 Feb 2022 16:12:34 +0100
Message-ID: <20220225161234.11073zpf0de419eq@webmail.u-szeged.hu>
Date:   Fri, 25 Feb 2022 16:12:34 +0100
From:   tibor.gyori@chem.u-szeged.hu
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: Meaning of negative memory_channel value in rasdaemon message
References: <20220211234058.81443i8317qnq77e@webmail.u-szeged.hu>
 <Ygvb0MclEFfDNqnQ@yaz-ubuntu>
In-Reply-To: <Ygvb0MclEFfDNqnQ@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-2;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Internet Messaging Program (IMP) H3 (4.3.11)
X-SZTE-local: YES
X-SZTE-HU-local: YES
X-Brightmail-Tracker: H4sIAAAAAAAAA11TfUwTdxjmrgWuXQ+PK21fy9csGDYchRETGCMqmC1kxsjM3B9sjrX2oB2l
        JT06QZfwMXGFYWDqAnbEUSB8DUFwQ0gUDcoUBGUKS5RNmMCAKh9i+HKAu6N8FP97f/f8nud9
        nnvuMA5Zy5NiGl0yZdAptDInPvd6pYYT8OQ5KIN6T4SEdneko6EtN/u5e9CorPtLTlEvGryi
        0Rh+uIrSar6mDIG7vuSrL9/I4yQtEylTT+5x05GneA7Cw4DYCVm9tdwchI+RRCsCE9ctq4cs
        FFotz1DboQaBurFeR9uhEYGZlgxHlo8TEWCu7OLkIBjGJbZDp1XFPnYiZFBUZnViZzfibXh8
        YXblOofwgom7uRx2FhIfwaOmkpWZJBTQvbjgzM48wh+q8gZW5V2h/dwQ18aNhrpvm7nsKg7h
        DhXLmO3xDii3PF1xICJCoWqMYkdgmKVFLraMblA8ZkXzETeznabZTtO8oWm20yxGuNWImKJT
        E+VxRxVardwYQB+j4imVXG1sQJgWig0pc03IQtesvBVBMaQVOYShMil+lm89TAqVelWqWkGr
        Y2mjMlFD0xq9TibCi/4GJemyjhmMWoqWeeHPX4qUpMSOQidpjmj0RjrWaNAyvWAcmRt+3sRw
        cZUi9Rhl0NuorYg7xpVJcLI391OSiFckUwkUlUQZ1tAvMEzmiSMODg6k2MBYT4nTaJmvyN4T
        4HunGF1Xe9hmaxt+a5GxJd1M3OwMxXityEFMINtq20LSSYpEWhNvv8ENlw+xztcgm7onPr7E
        qIs3CPbKHUgidmWy7yqH5Or0OkrqgZ/1EitJEXtbbdRtziCV4ANsBsIOXVkifRMP2S1Rkls3
        0ez3yFZqxMCKzCIYwryMM2x5rsy/9loIIR7BrhCsIrYMHvgEm0G0ft1eOriMUSSyBPBDIw3f
        v+pCYeG7bhTmB6adYLG0EINzPcN8GMq4KIDCmRcCWC5vwSF7es4F2jsubIGezHkC+jJLXaF+
        1iSEyu5rQhgteyCCiwV1Yvhz6JoEOpfa3GH53k0PKCmt94bm8axtUNJm8oH5tkkfaJj7zRea
        7t/ZDrerh/2gqaDiLbhiyXwH/quaDIBXoyVyWG4YlluZ+tCN+pIVryd3w4NixWx9q9BafZ2L
        K/WtE+yzS9PRikJRqs+zGO9B1z3HBUFj+yz7E5ba2o8m+qXVPJ6bOSQRPszsN0fcyeb1WnJV
        vvXN1EHp6ODVwd/Nfup/YppqbuTX+fKjzlCx4T9X14yUfTPIi2z88a8QfVwcflgd5z798Sfj
        VcUv66R396IxDg86c07m5ZV+/sekh7+pLvBfs9oyGpMQubvIOVq761RYcXKQOsN5tnN/4fFb
        l5HzwolHISc829udUo9U9xWqC34KCH7vl5p9Ix5fTV0qGNnxQU+lPuz26UhvL++JmZ2khzZc
        WZQWXH7J9/3PUrtN/YGnsj/kx4fl/0oLMk6H1UaadJyqvYWO1jSXh47tYZ6BB9yH4g6c3PKG
        jEurFe/6cwy04n/h4AugwQUAAA==
X-SZTE-AVcheck: YES
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Idézet (Yazen Ghannam <yazen.ghannam@amd.com>):

> On Fri, Feb 11, 2022 at 11:40:58PM +0100, tibor.gyori@chem.u-szeged.hu wrote:
>> Dear EDAC list,
>>
>> when rasdaemon reports a memory error, what does it mean for the
>> memory_channel value to be negative?
>>
>> Example:
>> Feb 11 22:34:40 CRD-MILAN-3 rasdaemon[918]:            <...>-42552 [001]
>> 0.007845: mce_record:           2022-02-11 22:34:40 +0100 Unified Memory
>> Controller (bank=18), status= 9c2040000000011b, Corrected error, no action
>> required., mci=CECC, mca= DRAM ECC error.
>> Feb 11 22:34:40 CRD-MILAN-3 rasdaemon[918]:  Memory Error 'mem-tx: generic
>> read, tx: generic, level: L3/generic', memory_channel=-1,csrow=3, cpu_type=
>> AMD Scalable MCA, cpu= 1, socketid= 0, misc= d01a0c7b01000000, addr=
>> 2fa07780, synd= e4da80000a800603, ipid= 9600350f00, mcgstatus=0, mcgcap=
>> 118, apicid= 1
>>
>> Is -1 a magic value for memory_channel? On the AMD Milan platform, I would
>> expect that memory channels would be numbered from 0 to 7. I googled for a
>> bit, but could not find where this sort of stuff would be documented.
>>
>
> Hi Tibor,
>
> Which version of rasdaemon are you using?
>
> You may be missing the following commit which is including v0.6.7.
>
> https://github.com/mchehab/rasdaemon/commit/854364ba44aee9bc5646f6537fc744b0b54aff37
>
> Thanks,
> Yazen
>
>

Dear Yazen,

Thanks for taking the time to reply. Upon further investigation it  
looks like the rasdaemon package provided by Ubuntu 20.04 is indeed  
missing the commit you specified.
Building rasdaemon from source has resolved this particular issue,  
although I have to say it was not without bumps on the road.
For what its worth, looking at the GitHub repo, I am somewhat  
concerned that rasdaemon might be becoming unmaintained. No commits  
have been made since Aug 2021, and reasonable-looking PRs are not  
getting reviewed.

Best wishes,
Tibor Gyõri

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
