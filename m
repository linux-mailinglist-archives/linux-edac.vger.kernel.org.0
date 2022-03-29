Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390394EB030
	for <lists+linux-edac@lfdr.de>; Tue, 29 Mar 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiC2P0B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 29 Mar 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiC2P0B (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 29 Mar 2022 11:26:01 -0400
X-Greylist: delayed 1523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 08:24:17 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB422BC3
        for <linux-edac@vger.kernel.org>; Tue, 29 Mar 2022 08:24:16 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with ESMTP id 22TDK6if012342;
        Tue, 29 Mar 2022 15:58:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=lEBXlVIia/ZC8aDGibfGXF0VmAeSEZd/fxUpoJqRSjg=;
 b=PdVuw6KGBvnhPnkfmoAAkGV6pVdHrcqZEoqADZ4i5k0yMnFK6s0b6AvN+9X/VIAtMse5
 cQj4CT8EEbu8YVXLQSQq9+zJxegavWCjQs2doMjLFOU067wsSasoxnTTiYUwu/9hIE5/
 +0ynm4tCqjmvEI1cnvI67S4UmwpC2Lp9QwBEokudKH1d9Yd/xIGbTGST9JWPpCTsNSpD
 5mds0qeNGI/bGdd6stJM0hYjnrz4IZrTF4hBjetEKXrpz6MPFuDYiYow6zs43CXIeYz/
 /dU/1XyA+qVpV841BYvIaZkwkWVuwKmAAXrI5zCQBleg8Ku6w+6wGa9Ic3mjk0TgvwYZ 1g== 
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
        by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3f1tywyfyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 15:58:51 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 22TEoChV002241;
        Tue, 29 Mar 2022 10:58:50 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint3.akamai.com with ESMTP id 3f2g477kr3-1;
        Tue, 29 Mar 2022 10:58:50 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 750AD60494;
        Tue, 29 Mar 2022 14:58:50 +0000 (GMT)
Message-ID: <8e44d499-ad55-d90a-d4e6-2a97aa6d0c41@akamai.com>
Date:   Tue, 29 Mar 2022 10:58:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] EDAC/ie31200: Add Skylake-S support
Content-Language: en-US
To:     joshuahant@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322184717.29882-1-joshuahant@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20220322184717.29882-1-joshuahant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-29_05:2022-03-29,2022-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290090
X-Proofpoint-GUID: 3699bTS29VG-4cRLp8e2QsfVNTK3I_f-
X-Proofpoint-ORIG-GUID: 3699bTS29VG-4cRLp8e2QsfVNTK3I_f-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_05,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/22/22 14:47, joshuahant@gmail.com wrote:
> From: Josh Hant <joshuahant@gmail.com>
> 
> Add device IDs for Skylake-S CPUs according to datasheet.
> 
> Signed-off-by: Josh Hant <joshuahant@gmail.com>
> ---
> Dear all,
> 
> I found that edac-util -v shows no memory controllers when using an
> Intel i5-6100T with a Supermicro X11SAE motherboard. With this patch,
> the ECC memory is detected. I tried to follow previous patches
> that added new families of processors to the module.
> 
> This is my first submission to the kernel so please let me know if I
> missed something in the process.
> 
> Thanks,
> Josh Hant
> 


Hi Josh,

Thanks for your submission! Some comments below.

>  drivers/edac/ie31200_edac.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index 9a9ff5ad611a..96a3f70d06e6 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -20,11 +20,14 @@
>   * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
>   * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
>   * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
> + * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
> + * 191f: 6th Gen Core Quad-Core Processor Host Bridge/DRAM Registers
>   * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
>   *
>   * Based on Intel specification:
>   * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf__;!!GjvTz_vk!AMVZ8h7gNGrptmwFk4tdnr0n6gUXJhZWRRjaZ3_usWEhORCh3fhbT-HVOitdUQ$ 
>   * https://urldefense.com/v3/__http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html__;!!GjvTz_vk!AMVZ8h7gNGrptmwFk4tdnr0n6gUXJhZWRRjaZ3_usWEhORCh3fhbT-HdDfO4eA$ 
> + * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/desktop-6th-gen-core-family-datasheet-vol-2.pdf__;!!GjvTz_vk!AMVZ8h7gNGrptmwFk4tdnr0n6gUXJhZWRRjaZ3_usWEhORCh3fhbT-Ef_03qbw$ 


I didn't find register #s in the above doc. But this one seems to have them:

https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v6-vol-2-datasheet.pdf


>   * https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html__;!!GjvTz_vk!AMVZ8h7gNGrptmwFk4tdnr0n6gUXJhZWRRjaZ3_usWEhORCh3fhbT-EznD3gEQ$ 
>   * https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html__;!!GjvTz_vk!AMVZ8h7gNGrptmwFk4tdnr0n6gUXJhZWRRjaZ3_usWEhORCh3fhbT-FmC7_jRg$ 
>   *
> @@ -53,15 +56,17 @@
>  #define ie31200_printk(level, fmt, arg...) \
>  	edac_printk(level, "ie31200", fmt, ##arg)
> 
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_1 0x0108
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_2 0x010c
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_3 0x0150
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_4 0x0158
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_5 0x015c
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_6 0x0c04
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_7 0x0c08
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_8 0x1918
> -#define PCI_DEVICE_ID_INTEL_IE31200_HB_9 0x5918
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_1  0x0108
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_2  0x010c
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_3  0x0150
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_4  0x0158
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_5  0x015c
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_6  0x0c04
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_7  0x0c08
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_8  0x190F
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_9  0x1918
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_10 0x191F
> +#define PCI_DEVICE_ID_INTEL_IE31200_HB_11 0x5918
> 
>  /* Coffee Lake-S */
>  #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK 0x3e00
> @@ -80,6 +85,7 @@
>  #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
>  	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
>  	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
>  	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
>  	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))

Looks like PCI_DEVICE_ID_INTEL_IE31200_HB_11 is missing from this check? IE you added
two new device ids, but added only 1 new check?

> 
> @@ -577,6 +583,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> --
> 2.34.1
> 


Also, just to confirm that after this patch the edac memory info/size is consistent with
what's in /proc/meminfo, dmidecode -t memory?

Thanks,

-Jason
