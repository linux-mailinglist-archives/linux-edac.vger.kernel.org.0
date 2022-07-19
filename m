Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50F57A47A
	for <lists+linux-edac@lfdr.de>; Tue, 19 Jul 2022 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbiGSRCs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jul 2022 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGSRCr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 19 Jul 2022 13:02:47 -0400
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299757E13;
        Tue, 19 Jul 2022 10:02:46 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.17.1.5/8.17.1.5) with ESMTP id 26JGER6A013822;
        Tue, 19 Jul 2022 18:02:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=hCYmL10Y55Wf+5/025sUTInX4vHKU+oVcdA4TA/O8lQ=;
 b=odOITHjnhIlksQrrYcsw3a225HKUuaH/k4ROkm4ZDhMRD5v/DwEEscXU0egNvrBuPfjH
 uNmVDk2XnFAdRKbBfihNJY6VtcvrBWDF3yNDScid1rppaf94bCvW+3/FfvBTwZL+ky1N
 WwnYn/I38fWWSNeo90c1mkIsDKTtSfO3IxrDpnMm/YS5FZNK/H94QBXntTgyvaO16zSd
 T4iiXRcK7YpPVwcX+9NGulGAwWjZCBnV408G9L61KOQ1yOazUh/vfKttQ3Nu5VzC4z9B
 eU+2MdaWHNVpdhXgUX/uFUXZ/o+nV0/m5foI0Vf94tTgbAgGIh8OIVmHNp+9Q2VoH8i8 rA== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3hdsknkwxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 18:02:44 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDj4bC008001;
        Tue, 19 Jul 2022 13:02:43 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3hbrny43qq-1;
        Tue, 19 Jul 2022 13:02:43 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 1BD062D949;
        Tue, 19 Jul 2022 17:02:43 +0000 (GMT)
Message-ID: <375068c7-2cb7-db23-2b1d-956e2673788f@akamai.com>
Date:   Tue, 19 Jul 2022 13:02:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] EDAC/ie31200: Add Skylake-S support
Content-Language: en-US
To:     Josh Hant <joshuahant@gmail.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ab77d779-31a6-62f7-a81c-97d6b9a35018@akamai.com>
 <20220716005348.13756-1-joshuahant@gmail.com>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20220716005348.13756-1-joshuahant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_04,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190070
X-Proofpoint-GUID: ys9E15oVfxXPYn2ynyp2RcILKfMBkavb
X-Proofpoint-ORIG-GUID: ys9E15oVfxXPYn2ynyp2RcILKfMBkavb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190071
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Josh,

Looks good to me.

Acked-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason

On 7/15/22 20:53, Josh Hant wrote:
> Add device IDs for Skylake-S CPUs according to datasheet.
> 
> Signed-off-by: Josh Hant <joshuahant@gmail.com>
> ---
> Here is the patch with both documents included.
> 
> Thanks,
> Josh
> 
>  drivers/edac/ie31200_edac.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index 9a9ff5ad611a..9ef13570f2e5 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -20,11 +20,15 @@
>   * 0c08: Xeon E3-1200 v3 Processor DRAM Controller
>   * 1918: Xeon E3-1200 v5 Skylake Host Bridge/DRAM Registers
>   * 5918: Xeon E3-1200 Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers
> + * 190f: 6th Gen Core Dual-Core Processor Host Bridge/DRAM Registers
> + * 191f: 6th Gen Core Quad-Core Processor Host Bridge/DRAM Registers
>   * 3e..: 8th/9th Gen Core Processor Host Bridge/DRAM Registers
>   *
>   * Based on Intel specification:
>   * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v3-vol-2-datasheet.pdf__;!!GjvTz_vk!XBdwBoztmGI-G7Ww0phwMfPvN7k3bH9_oq608DA9wgZX2IvKs2b7iWC9cI9-LQX5DtlulP9A73HxkjTU$ 
>   * https://urldefense.com/v3/__http://www.intel.com/content/www/us/en/processors/xeon/xeon-e3-1200-family-vol-2-datasheet.html__;!!GjvTz_vk!XBdwBoztmGI-G7Ww0phwMfPvN7k3bH9_oq608DA9wgZX2IvKs2b7iWC9cI9-LQX5DtlulP9A7-ew3RWq$ 
> + * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/desktop-6th-gen-core-family-datasheet-vol-2.pdf__;!!GjvTz_vk!XBdwBoztmGI-G7Ww0phwMfPvN7k3bH9_oq608DA9wgZX2IvKs2b7iWC9cI9-LQX5DtlulP9A7yvc2EC2$ 
> + * https://urldefense.com/v3/__https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e3-1200v6-vol-2-datasheet.pdf__;!!GjvTz_vk!XBdwBoztmGI-G7Ww0phwMfPvN7k3bH9_oq608DA9wgZX2IvKs2b7iWC9cI9-LQX5DtlulP9A7zHkZoPB$ 
>   * https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/processors/core/7th-gen-core-family-mobile-h-processor-lines-datasheet-vol-2.html__;!!GjvTz_vk!XBdwBoztmGI-G7Ww0phwMfPvN7k3bH9_oq608DA9wgZX2IvKs2b7iWC9cI9-LQX5DtlulP9A75WQ5pDp$ 
>   * https://urldefense.com/v3/__https://www.intel.com/content/www/us/en/products/docs/processors/core/8th-gen-core-family-datasheet-vol-2.html__;!!GjvTz_vk!XBdwBoztmGI-G7Ww0phwMfPvN7k3bH9_oq608DA9wgZX2IvKs2b7iWC9cI9-LQX5DtlulP9A7wPGcDEO$ 
>   *
> @@ -53,15 +57,17 @@
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
> @@ -80,6 +86,8 @@
>  #define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
>  	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
>  	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
> +	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
>  	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
>  	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
> 
> @@ -577,6 +585,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
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
