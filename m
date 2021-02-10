Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E84316A3F
	for <lists+linux-edac@lfdr.de>; Wed, 10 Feb 2021 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBJPci (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Feb 2021 10:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBJPcg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Feb 2021 10:32:36 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E20C061574
        for <linux-edac@vger.kernel.org>; Wed, 10 Feb 2021 07:31:56 -0800 (PST)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 11AFUcxS023194;
        Wed, 10 Feb 2021 15:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=ZJ4tofDa5ThylRgCenJ0haEh0/XhY48EBFl46HTA/gM=;
 b=ZrEMgnPAvVB4I7OR6WNeo0vXdRoaEHW5FLxY05nB8gbUcERAn8koKXThQ+6eSL0pFq0B
 Upo3ZGFUrMLCn/W/cWYEWCJqDDdFG7K37pdS51tl0tbuaihOsql9mH4l/Y29fH31KFT2
 0QgQWrzxhwukGHd3b84lobeYOTHtY8LCGnGy6du98fGqgL5AWt/oXFVY9amMk/biGdC5
 mbci93RKsFhj+DSQMPq9cKdUQdcXPdJDG+zm7TqgJJXTpnU/8qaMHVAikpdWJEtbnKFI
 M9eMpEgNkY+RbuhCf6fo3Shxxv+nYILCy3BV0ZAb6naqncA++s17avbkFzE+yG1NptNj nw== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 36hrv22e2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 15:31:52 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 11AFIxeZ016953;
        Wed, 10 Feb 2021 10:31:52 -0500
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
        by prod-mail-ppoint4.akamai.com with ESMTP id 36k5nkstcm-1;
        Wed, 10 Feb 2021 10:31:51 -0500
Received: from [0.0.0.0] (unknown [172.27.119.138])
        by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 9511E374;
        Wed, 10 Feb 2021 15:31:51 +0000 (GMT)
Subject: Re: ie31200_edac missing PCI ID for i3-4370
From:   Jason Baron <jbaron@akamai.com>
To:     Paul Marks <paul@pmarks.net>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de
References: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
 <ecb895bf-f384-e5e6-d434-d3a8e06eaf47@akamai.com>
 <CAHq9+Si+oyG=8j6xs-a=Jq+8vxU3eHzNOzbA9JXonsFvHd=O=A@mail.gmail.com>
 <77c3f46c-3519-d791-7bfe-97186d6893bb@akamai.com>
 <CAHq9+ShvTowrZusjxFV+yGzM=gCmG_mFJAsKwaHQ=qi_OknKCA@mail.gmail.com>
 <2ddf6488-b93a-7400-228b-bae7a2c96608@akamai.com>
Message-ID: <bdd0f8d7-a0d9-aa11-e12b-f26d067ff424@akamai.com>
Date:   Wed, 10 Feb 2021 10:31:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2ddf6488-b93a-7400-228b-bae7a2c96608@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_06:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=880 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100146
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_06:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=785 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100147
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 72.247.45.32)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint4
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2/9/21 10:27 PM, Jason Baron wrote:
> 
> 
> On 2/9/21 6:58 PM, Paul Marks wrote:
>> On Tue, Feb 9, 2021 at 2:25 PM Jason Baron <jbaron@akamai.com> wrote:
>>> On 2/4/21 6:22 PM, Paul Marks wrote:
>>>> On Thu, Feb 4, 2021 at 2:59 PM Jason Baron <jbaron@akamai.com> wrote:
>>>>> On 1/31/21 7:07 PM, Paul Marks wrote:
>>>>>> I have an ASRock C226M WS with an i3-4370 CPU.
>>>>>>
>>>>>> # lspci -vnn
>>>>>> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
>>>>>>              DRAM Controller [8086:0c00] (rev 06)
>>>>>>          Subsystem: ASRock Incorporation 4th Gen Core Processor
>>>>>>              DRAM Controller [1849:0c00]
>>>>>>          Flags: bus master, fast devsel, latency 0
>>>>>>          Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>>>>>>          Kernel driver in use: hsw_uncore
>>>>>>
>>>>>> But edac-util doesn't work:
>>>>>>
>>>>>> # edac-util -v
>>>>>> edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data in sysfs
>>>>>>
>>>>>> I tried this ham-fisted patch:
>>>>>>
>>>>>> # diff -u ./drivers/edac/ie31200_edac.c{.old,}
>>>>>> --- ./drivers/edac/ie31200_edac.c.old
>>>>>> +++ ./drivers/edac/ie31200_edac.c
>>>>>> @@ -58,7 +58,7 @@
>>>>>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
>>>>>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
>>>>>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
>>>>>> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
>>>>>> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
>>>>>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
>>>>>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
>>>>>>   #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
>>>>> just curious why you removed here and didn't just add?
>>>> This is not a serious patch, just a one-liner to demonstrate the problem.
>>> Ok. Any chance you can find the datasheet that shows that this
>>> driver is using the appropriate registers for this hw? I didn't
>>> find it quickly looking...
>>>
>> I wouldn't know where to begin.  Do you have an example of a similar
>> datasheet from one of the known-good devices?
>>
>> I left "memtester" running on this machine, because it might increase
>> the odds of generating an ECC error someday.
> Hi Paul,
> 
> I have a list of them at the top of:
> drivers/edac/ie31200_edac.c
> 
> According to the following intel link it looks
> like '0xc[0-f]' is valid (page 52):

Sorry meant to write that as: '0x0c0[0-f]'.


> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf
> 
> So I'm fine with this patch (assuming it just
> becomes an addition).
> 
> Thanks,
> 
> -Jason
> 
