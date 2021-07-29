Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7F3DA922
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jul 2021 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhG2QdA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Jul 2021 12:33:00 -0400
Received: from mail-bn8nam08on2062.outbound.protection.outlook.com ([40.107.100.62]:40289
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229565AbhG2Qc7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Jul 2021 12:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oarwCEXfA4RGhtXjt8lfDxbt/CDOrERCYN+qiLAbCt05lqsdMFtn8mX1WeXhtUxTrs4/glgXBiuHIm0yug2/43/ukqTSd9VIswhyUdMkc7ksfBGiN997ZBU1tLilhtizia6eAELrZSSDOvISEhmyEetCuJgi4xV+hORpWrhhUDq8/mx/epySA5t05HAqoCMln/Q/ihWzSAeu9IeGSpRrUigGg2FMB8Z3MMVj64ejIvgDCJdD9XgUI+zoFhZ+crYyAlujPvvKgPZ5JiphIOQ2JmoP7ZvLRBEMX/2Psf8/DllQaSzbn1JnTeOWe1uH7EQ84KVAt0+R7ni+G6Ju3C9hYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48eUpSaHPklkDiVwxocpHuPqU8SKnFDuQ1AmAzfCu1E=;
 b=L8w6iZ30GwJuk5FtaQN9Khf9iX01KANYY5j7UVSZDy9SlJKooBWZchoc7L7dYwBbZgzINK5pEjnsmfr7m5X7OjG6pA4B02h0J0mJ/aeXuhf/yHk9wY+NVO/rolycc3pJlmQPWsP95b6f7fiDxL/DokbB3rZOgbGfGWjyBOsSUjGD0M0DMTGto9jurTgnVi3Ug2xawAsbuEt0ajEah/MYtogm0RmsFZiHDORheZSnr9tzv04MbAwFTzW+JpEW5JmLzWaVFVLKW96IFUh2M7XIO5+lwH4pdXilByBagiBjnJycqjo0tZM2kwDo8KU0pSTLkywuXW34KNv/cMho3QtyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48eUpSaHPklkDiVwxocpHuPqU8SKnFDuQ1AmAzfCu1E=;
 b=LkJiZ6e8plVKsJjLexO+ml9c67nTDREYKAs2kVtAWOulan0AsxBD6me07/KMq4+CDw+Z9CJTekh+UY1qc3rTSX0CKUbNqxcDgpJd9CXT1rUV1Byi485QgRu4SQDPX+cmX7A+CTAl78hCdsplicJrXvryum+vzQeayXi33ZqHqrs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3476.namprd12.prod.outlook.com (2603:10b6:408:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 16:32:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 16:32:52 +0000
Date:   Thu, 29 Jul 2021 12:32:45 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: Re: [PATCH 4/7] EDAC/mce_amd: extract node id from InstanceHi in IPID
Message-ID: <20210729163245.GA4318@aus-x-yghannam.amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-5-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630152828.162659-5-nchatrad@amd.com>
X-ClientProxiedBy: BN6PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:404:f7::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR11CA0060.namprd11.prod.outlook.com (2603:10b6:404:f7::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21 via Frontend Transport; Thu, 29 Jul 2021 16:32:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4d1cf6-c10a-4c92-6fbb-08d952ae8280
X-MS-TrafficTypeDiagnostic: BN8PR12MB3476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB34765B87ADB589F7038C40DEF8EB9@BN8PR12MB3476.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhBE3tQWcRHUCy0YzO0uH0VPp8zRv0RE10np19L/aCewPfCf7/cAbvwyfymHm6x0EhZ9aMN5rqTj1cDwLNkXtih2Z6heax5Ja8hPFxH+ZtNoIcMqvthnyphXVGdgqL/tt//5vexGvkQAc5DoSzjC/yQ4QMJWEHyNnRE+tBPPuczPDCX6kffeYmApW6eY/sUAUmjrLrGHJ/0BR56irX7sSVaW9cRqQ2Fw5X+QzXDBYrQaKHza8wBdid/ficn5IFdvF6KNReVFJyuMFlEOVp9l78p98Q5aFKu+g/zHBPwFWgC3zBWOrSeMsgiNqBYjnlL+RyRjE8ComzIY75LMOhbtH9YgifDzIPQicWQVM3rYRuifaT+67QoqGMsmjlVzW20MwGkI9UaDUIF/XGSHlQQMIPilGZEHnozYeRRVMrwpIZ2tH+A2ZddEGjH/HEfL0ttgtSKLD8p/D9o1FdR+P42EPK9QsffdxWYEN1fg0d9QKpTl65ExjVKs20HIhoOupurQQClvfSXkRZ3bAe4bAntSidaVkFTsZrJ3N8pZ4vlmLjiRF0CtskDZRiPSSTpUFrHvmLKrOBrS63HGcTJ8+iebWAcOK+xnbNE/OXCT5fYhpPx3Eva3BkNf5CdzI4DasDmYj8G+nun0jzuje+jie3oaBb9h2tDmiF5bKWKCxXq1b00LP/cO2bG9xLW2IE1JswNFGPdDgDHw37N9TZkxmhHUoaRQ59JZV4Cd/DrBWTkulcU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(6636002)(8676002)(956004)(478600001)(6666004)(38350700002)(38100700002)(66556008)(86362001)(4326008)(66946007)(66476007)(1076003)(83380400001)(6862004)(26005)(316002)(7696005)(5660300002)(44832011)(186003)(2906002)(8936002)(33656002)(55016002)(52116002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0XJvd5fDvgYA7MQb68qPUBh6f6QivRua8brfW9vMDeOtQbjst/XjqztvsSw?=
 =?us-ascii?Q?bkosjH5RW+dyOSpCVyQMSm2F8JTIEsMT33puubqfrlx0SH8dFIg2BjmcYvJT?=
 =?us-ascii?Q?WDyAp17b+BlzZPWF+SgrG2/F8ADPBdB6EVAPvctNh6MwwqB5gOYppLVVL2Rq?=
 =?us-ascii?Q?l8JNfWG38zfNo7p1ukyXU29A/yrNReOTeRUsBAFuO7tti0tM8GiluNl/gqJe?=
 =?us-ascii?Q?4I7i7xJvwDrjNrIlYigPBDHiePaKagROBiOxZrRp3EwTDUD6R7SF5a2yt765?=
 =?us-ascii?Q?smd/m4mi/HHHiDy4fLZ7+7zkvqWqHsP+bg1VX4Qss4YKL5rw2WmG0HDsAF12?=
 =?us-ascii?Q?/LAV0KMIetK3x7EgFEU/6FECry+LStHM970KsQxHteV5y5+8Ir0/PMOGQwkN?=
 =?us-ascii?Q?P9UzvtJsubNa4TU2Q4dloQ0qdChf1Nx6w50QeA/AzX0LZSzeZlUUGh+2xxm2?=
 =?us-ascii?Q?vn3I9FKC//iOYtAFV+pYBXByT6XQImmVVTG6axLVDVlonmHnHW8eqdjQf4qT?=
 =?us-ascii?Q?Kb/+RwONBda1NFw/zCuVMRBO+261y4Iz4qOPWYisSn+d42a2ZcVjdoxA5P1f?=
 =?us-ascii?Q?RxOnzXwsBxF3/PTM0phrcV0E3yIX6tufDidY1wAzHmynjOkDbjUEL6UCsw1n?=
 =?us-ascii?Q?Jh+3xGpcHTpG5gqdjaWa1AcRx9Dr3fHYrkjQuNrZKM/jaq48jLr4QgRQuoCD?=
 =?us-ascii?Q?dI1jOdG+7IeFwEDviYNJms38g8QwlD/fJs6b8JPYp7rnMvvJXao2wVoO7cLE?=
 =?us-ascii?Q?19Cb+FdLNOUnZCgf6HtekPo5qekohZQifmdlaqKanN0YUeAy39cUn5lCoDJV?=
 =?us-ascii?Q?U6In0tR12X9/IuAO7K7ptPhlyjtQm+4700MEZ4MQ/1VmsB+y6x1MtAKnIxiQ?=
 =?us-ascii?Q?5oaY/Pntu+wkhKSjleFN5se35WKv+Tz8Y3ygoIZLJGGlOsephzd0QpDKFU/Z?=
 =?us-ascii?Q?5B037Nx76CmEJGjtyW/fy1sHhgSefngWb4/ZuPscsf5LabOtKQsj9U5hQp0o?=
 =?us-ascii?Q?sY4ElI8lGgz3fUS3cvF7igH54t1mxVMJ/F75fuBrbw0St0xDIMC/8b+T5bX9?=
 =?us-ascii?Q?BKcJnc4Ct6ODOu2GkOnJQisFSKl17hcuJTyPfLPdQ4UxzpTHdp9QBwVILZ6f?=
 =?us-ascii?Q?3ENwJeysVT5ZZfScPHlZsw2fpkxT1Lz9nIE27kK+7/yB+g3kFjDSgFpOTmlE?=
 =?us-ascii?Q?iBx7EAt2kefj/Tgr+92580gwWPWw1sdQt/P/gceq8AwsBZ1QJ6UUQX3DBaaZ?=
 =?us-ascii?Q?SanT0FeHwb7Y3drxuo7vvLCm1RTg77EkRVldDPuI3MS7v6Q6MARFeolK9YaU?=
 =?us-ascii?Q?TI+MGbEK8RgNcxe1WJnSg1ko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4d1cf6-c10a-4c92-6fbb-08d952ae8280
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 16:32:52.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4zKZ1dMcVrV1Gw/7Fv3mJhF+Gz7Yx9/jK9RhhUF0D88Ac/jwrMr4QQXwi8DeLm6NbngOiOffST9dV7C6PUNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3476
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 08:58:25PM +0530, Naveen Krishna Chatradhi wrote:
> On AMD systems with SMCA banks on NONCPU nodes, the node id information
> is available in the InstanceHI[47:44] of the IPID register.

The doesn't read well to me. I saw this as saying "bits 47:44 of the
InstanceHi register". Also, the name of the field is "InstanceIdHi" in
the documentation.

I think it'd be more clear to say "available in MCA_IPID[47:44]
(InstanceIdHi)" or something similar. 

> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  drivers/edac/mce_amd.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 27d56920b469..364dfb6e359d 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -1049,6 +1049,7 @@ static void decode_smca_error(struct mce *m)
>  	enum smca_bank_types bank_type;
>  	const char *ip_name;
>  	u8 xec = XEC(m->status, xec_mask);
> +	u32 node_id = 0;

Why u32? Why not u16 to match topology_die_id() or int to match
decode_dram_ecc()?

>  
>  	if (m->bank >= ARRAY_SIZE(smca_banks))
>  		return;
> @@ -1072,8 +1073,18 @@ static void decode_smca_error(struct mce *m)
>  	if (xec < smca_mce_descs[bank_type].num_descs)
>  		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
>  
> -	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
> -		decode_dram_ecc(topology_die_id(m->extcpu), m);
> +	/*
> +	 * SMCA_UMC_V2 is used on the noncpu nodes, extract the node id
> +	 * from the InstanceHI[47:44] of the IPID register.
> +	 */
> +	if (bank_type == SMCA_UMC_V2 && xec == 0)
> +		node_id = ((m->ipid >> 44) & 0xF);
> +
> +	if (bank_type == SMCA_UMC && xec == 0)
> +		node_id = topology_die_id(m->extcpu);
> +
> +	if (decode_dram_ecc)
> +		decode_dram_ecc(node_id, m);

If decode_dram_ecc() is set, then this will call it on every MCA error
that comes in. Rather we only want to call it on DRAM ECC errors.

You could do something like this:

	if (decode_dram_ecc && xec == 0) {
		u32 node_id = 0;

		if (bank_type == SMCA_UMC)
			node_id = XXX;
		else if (bank_type == SMCA_UMC_V2)
			node_id = YYY;
		else
			return;

		decode_dram_ecc(node_id, m);
	}

This is just an example. Maybe you can save an indentation level by
negating those conditions and returning early, etc.

Thanks,
Yazen
