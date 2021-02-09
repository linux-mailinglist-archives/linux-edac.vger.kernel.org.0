Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794F23159BF
	for <lists+linux-edac@lfdr.de>; Tue,  9 Feb 2021 23:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhBIWyS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Feb 2021 17:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhBIW00 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Feb 2021 17:26:26 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F73C061788
        for <linux-edac@vger.kernel.org>; Tue,  9 Feb 2021 14:25:21 -0800 (PST)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 119MJsmh000684;
        Tue, 9 Feb 2021 22:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=7J97n5cbm2Mojb7XGY9YDYv8d/5Ddo3OTurQp9M3Tx0=;
 b=fFD8DySlCfqq1dJgDBD+Z1GZkxN2+DCx14zOwyUpvLZU4itfrjJ2x0b5qsVn9jfGkWaw
 yPbaIT1Jw5LXgLvtN/Nq5IIto9CLx7bVeMK/HGiqzu9g7pFM76alNvbjndeEEuWZeaDB
 IJBI8u0a+M0jkbHfOzvNI2vSNf+g/KcEaEk5OcRf+n7vqpqUDtSDykN1hTvV43aMzM5k
 utg0s5d0CEaIx37Eo9gZM/pNwSSdVGO5kCTSbHHucL8V0+offcd2fKuHpYeY2304xqR+
 LDdfGmWldPM34RBEmeTMEkQUFa/CoIHyuckODMbt71MuBq+Az9XQ2XnrVwDJbE/SjQY+ Ig== 
Received: from prod-mail-ppoint7 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 36hrfr8hur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:25:14 +0000
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
        by prod-mail-ppoint7.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 119MIh12024184;
        Tue, 9 Feb 2021 17:25:13 -0500
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint7.akamai.com with ESMTP id 36hqb3c9g8-1;
        Tue, 09 Feb 2021 17:25:13 -0500
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id D772C58E;
        Tue,  9 Feb 2021 22:25:12 +0000 (GMT)
Subject: Re: ie31200_edac missing PCI ID for i3-4370
To:     Paul Marks <paul@pmarks.net>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, m.chehab@samsung.com
References: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
 <ecb895bf-f384-e5e6-d434-d3a8e06eaf47@akamai.com>
 <CAHq9+Si+oyG=8j6xs-a=Jq+8vxU3eHzNOzbA9JXonsFvHd=O=A@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <77c3f46c-3519-d791-7bfe-97186d6893bb@akamai.com>
Date:   Tue, 9 Feb 2021 17:25:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHq9+Si+oyG=8j6xs-a=Jq+8vxU3eHzNOzbA9JXonsFvHd=O=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=942 bulkscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090114
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxlogscore=847 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090114
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.33)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint7
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/4/21 6:22 PM, Paul Marks wrote:
> On Thu, Feb 4, 2021 at 2:59 PM Jason Baron <jbaron@akamai.com> wrote:
>>
>> On 1/31/21 7:07 PM, Paul Marks wrote:
>>> I have an ASRock C226M WS with an i3-4370 CPU.
>>>
>>> # lspci -vnn
>>> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
>>>             DRAM Controller [8086:0c00] (rev 06)
>>>         Subsystem: ASRock Incorporation 4th Gen Core Processor
>>>             DRAM Controller [1849:0c00]
>>>         Flags: bus master, fast devsel, latency 0
>>>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>>>         Kernel driver in use: hsw_uncore
>>>
>>> But edac-util doesn't work:
>>>
>>> # edac-util -v
>>> edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data in sysfs
>>>
>>> I tried this ham-fisted patch:
>>>
>>> # diff -u ./drivers/edac/ie31200_edac.c{.old,}
>>> --- ./drivers/edac/ie31200_edac.c.old
>>> +++ ./drivers/edac/ie31200_edac.c
>>> @@ -58,7 +58,7 @@
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
>>> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
>>> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
>>
>> just curious why you removed here and didn't just add?
> 
> This is not a serious patch, just a one-liner to demonstrate the problem.

Ok. Any chance you can find the datasheet that shows that this
driver is using the appropriate registers for this hw? I didn't
find it quickly looking...

Thanks,

-Jason

