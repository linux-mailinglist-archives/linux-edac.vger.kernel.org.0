Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1152310143
	for <lists+linux-edac@lfdr.de>; Fri,  5 Feb 2021 01:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhBEADt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Feb 2021 19:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhBEADr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 4 Feb 2021 19:03:47 -0500
X-Greylist: delayed 3819 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Feb 2021 16:03:07 PST
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6040C0613D6
        for <linux-edac@vger.kernel.org>; Thu,  4 Feb 2021 16:03:07 -0800 (PST)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 114MwoNk029952;
        Thu, 4 Feb 2021 22:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=dq2CKR0ytaupC8dX9//XiT5yiw4uDdwTsKVXV+GZ8hM=;
 b=oddFohelLwX5gLBGcmEcSWG2hUczaaH00Y6GnbT2fWACqxT5KiZV1Th8eGibCYYAfmFL
 j0eozruwzB1W8e3o/8B/lmcTkM/RKOQH+3Yq91Zt3qtyBJZl1za86APOCjvnmp3YNSST
 1VgXUgi3izCqbld3OfSQ7A0DSuV25VhhRj8A2uma2J6O0CsLBAq59pMPwZ30wnq/azSP
 ClUm4dn+0lD2jlbCahO8jnmvGGGQN7n7sobcrUQQ8Eyy99yDIZeJEXru6/6a8942pi0Z
 jfA2uYl9UuakSZrtoO7RsE8JlsobQepwG6ocSXZl/vwaXnPflpuYtihTMAfgOePoXKfr 1g== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 36f8e05y61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 22:59:20 +0000
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 114MnsbE001523;
        Thu, 4 Feb 2021 14:59:19 -0800
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint5.akamai.com with ESMTP id 36d6afgf5m-1;
        Thu, 04 Feb 2021 14:59:19 -0800
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id BBE0C24E3A;
        Thu,  4 Feb 2021 22:59:18 +0000 (GMT)
Subject: Re: ie31200_edac missing PCI ID for i3-4370
To:     Paul Marks <paul@pmarks.net>, linux-edac@vger.kernel.org
Cc:     bp@alien8.de, m.chehab@samsung.com
References: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <ecb895bf-f384-e5e6-d434-d3a8e06eaf47@akamai.com>
Date:   Thu, 4 Feb 2021 17:59:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHq9+ShGiB_H6-E=L398zYR=ja16r2OuvJZfU4KLof=segyJbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_12:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040139
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=819
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040139
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.60)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint5
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 1/31/21 7:07 PM, Paul Marks wrote:
> I have an ASRock C226M WS with an i3-4370 CPU.
> 
> # lspci -vnn
> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
>             DRAM Controller [8086:0c00] (rev 06)
>         Subsystem: ASRock Incorporation 4th Gen Core Processor
>             DRAM Controller [1849:0c00]
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>         Kernel driver in use: hsw_uncore
> 
> But edac-util doesn't work:
> 
> # edac-util -v
> edac-util: Fatal: Unable to get EDAC data: Unable to find EDAC data in sysfs
> 
> I tried this ham-fisted patch:
> 
> # diff -u ./drivers/edac/ie31200_edac.c{.old,}
> --- ./drivers/edac/ie31200_edac.c.old
> +++ ./drivers/edac/ie31200_edac.c
> @@ -58,7 +58,7 @@
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c00
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918

just curious why you removed here and didn't just add?

> 
> And it seems happy now:
> 
> # lspci -vnn
> 00:00.0 Host bridge [0600]: Intel Corporation 4th Gen Core Processor
>             DRAM Controller [8086:0c00] (rev 06)
>         Subsystem: ASRock Incorporation 4th Gen Core Processor
>             DRAM Controller [1849:0c00]
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
>         Kernel driver in use: hsw_uncore
>         Kernel modules: ie31200_edac
> 
> # edac-util -v
> mc0: 0 Uncorrected Errors with no DIMM info
> mc0: 0 Corrected Errors with no DIMM info
> mc0: csrow0: 0 Uncorrected Errors
> mc0: csrow0: mc#0csrow#0channel#0: 0 Corrected Errors
> mc0: csrow1: 0 Uncorrected Errors
> mc0: csrow1: mc#0csrow#1channel#0: 0 Corrected Errors
> edac-util: No errors to report.
> 
> I don't know if it's truly working because I can't overclock the RAM
> to induce ECC errors, but still I think adding 8086:0c00 to this
> driver could be useful.
> 

Cool yeah - I think it makes sense to add if can confirm
that the Intel datasheet says that this cpu uses the same
registers to read errors from as the others. I can certainly
confirm that the other pci ids do increment ce counts...

Thanks,

-Jason
