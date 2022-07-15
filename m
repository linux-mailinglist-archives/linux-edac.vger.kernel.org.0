Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05AC57648A
	for <lists+linux-edac@lfdr.de>; Fri, 15 Jul 2022 17:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGOPjE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jul 2022 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGOPjC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Jul 2022 11:39:02 -0400
X-Greylist: delayed 2776 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 08:39:01 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21723222B4;
        Fri, 15 Jul 2022 08:39:00 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.17.1.5/8.17.1.5) with ESMTP id 26FEPHU2013883;
        Fri, 15 Jul 2022 15:52:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=n3/u7Xb/IhKRXOG6IcljUKALO6zCGBgcAdJo43NbcvE=;
 b=ohQlKxLyIIUqtetRW+ExkQHKkClWIfI3NFlMd0L2aLTn2Am8HVNxbA3QLI5doKZbgFTY
 c74tRZtx1gbyJPuNOM2A+sNtpXfQnZlA17fGAOtHxMLb7CRq1Ccw70KbGsM1ACwrxI4T
 rKwtoLbgJyKVs8to+AtlrfEmkZLqbPoJsQHjArqHn3+Ai+2OGKbm7FUVgIIxFAv0Grjn
 OrWDdrF/LeEbJj4L+Z8OKqjldbRcAv4FVkTDAFPxicvzjoJ/x+oZThGRGY9dO7zqS43R
 Rzv7VSAolGdGJkuXoVubEDU87uLhrntg079KgzEc2PumIfXtY4F5n+gy8v5FSGigeGIX 7g== 
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
        by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3haty51v06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 15:52:42 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.17.1.5/8.17.1.5) with ESMTP id 26FC4lQO032668;
        Fri, 15 Jul 2022 10:52:41 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 3h7q6pq355-1;
        Fri, 15 Jul 2022 10:52:41 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 21DB8600E6;
        Fri, 15 Jul 2022 14:52:41 +0000 (GMT)
Message-ID: <ab77d779-31a6-62f7-a81c-97d6b9a35018@akamai.com>
Date:   Fri, 15 Jul 2022 10:52:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] EDAC/ie31200: Add Skylake-S support
Content-Language: en-US
To:     Josh Hant <joshuahant@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8e44d499-ad55-d90a-d4e6-2a97aa6d0c41@akamai.com>
 <20220712102121.20812-1-joshuahant@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20220712102121.20812-1-joshuahant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_07,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150065
X-Proofpoint-GUID: VYuJZ7Yu-c3A4TP0qw9DDnYQRnTdAlgr
X-Proofpoint-ORIG-GUID: VYuJZ7Yu-c3A4TP0qw9DDnYQRnTdAlgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_07,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150065
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 7/12/22 06:21, Josh Hant wrote:
> Add device IDs for Skylake-S CPUs according to datasheet.
> 
> Signed-off-by: Josh Hant <joshuahant@gmail.com>
> ---
> Hi Jason,
> 
> Sorry for the late response. I added the missing check you asked for. I
> kept the documentation the same for now. I found the register in table 3
> of the original document I linked. If you would rather I provide the one
> you linked, I'll do that in the next patch.

Yes, I think the link I had was useful, for example it had register offsets
for things like ECCERRLOG which I didn't see in the reference you linked.
Maybe just include both?


> 
> I confirmed that the name and size in /proc/meminfo is consistent with
> what is in /sys/devices/system/edac/mc/mc0.

Ok, great. Yeah let's just add the extra documentation link and then the
patch seems fine.

Thanks,

-Jason

> 
> Thanks
> -Josh
>  drivers/edac/ie31200_edac.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index 9a9ff5ad611a..3d322603bce8 100644
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
>   * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf__;!!GjvTz_vk!R59Q1Bnf9RyI0ZIv2OAIqpD_lPa6_sdWaeFoH595ZLDCCri1SLs1ZCbrgr53QjTZAyLVmoiv9oZ-6raD$ 
>   * https://urldefense.com/v3/__http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html__;!!GjvTz_vk!R59Q1Bnf9RyI0ZIv2OAIqpD_lPa6_sdWaeFoH595ZLDCCri1SLs1ZCbrgr53QjTZAyLVmoiv9m6NRBGA$ 
> + * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/desktop-6th-gen-core-family-datasheet-vol-2.pdf__;!!GjvTz_vk!R59Q1Bnf9RyI0ZIv2OAIqpD_lPa6_sdWaeFoH595ZLDCCri1SLs1ZCbrgr53QjTZAyLVmoiv9gF6-zMQ$ 
>   * https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html__;!!GjvTz_vk!R59Q1Bnf9RyI0ZIv2OAIqpD_lPa6_sdWaeFoH595ZLDCCri1SLs1ZCbrgr53QjTZAyLVmoiv9q7dFz1H$ 
>   * https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html__;!!GjvTz_vk!R59Q1Bnf9RyI0ZIv2OAIqpD_lPa6_sdWaeFoH595ZLDCCri1SLs1ZCbrgr53QjTZAyLVmoiv9vbMAhyi$ 
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
> @@ -80,6 +85,8 @@
>  #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
>  	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
>  	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
>  	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
>  	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
> 
> @@ -577,6 +584,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_10),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_11),     PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
>  	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
> --
> 2.34.3
> 
