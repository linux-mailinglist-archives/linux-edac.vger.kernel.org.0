Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53F4E574C
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiCWRVI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRVH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 13:21:07 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17904476C
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 10:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDAKvEd6QQ5CAEwqA/71mTBhELVgD4nLYockBJkXm3zr0l0/eGul2RZWuBxk98F50wRHGawA1/+YeCyfqkdNCZ6X0i3CzBWyJ0Nv2BdwmzpIlxZ+2Z30p8bxncQDqOjry4sebHPwOg3259/RCdMHzbxzP2WW+aYq4ErAq/SdWm7jlQ/8nFn7oCeXGzPK4fbvUshdIjKIxUFDRDsrE+rni8UsXuGR/66IXKusJKn3p86aDeodw8qQljvIyG4FeWp3uvcyWW1bzY2ewxvjVrRd364PoH21Pea0opt27qddj1F71oXZrgFqmJ8uQiHN2aja2ECnr0mzpPkd+VNmS5Krkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnRxDcId7MRZ1CkIlc4WIat7D1m34xRU3B4i4ynZ5ag=;
 b=ewIBEh1aZeTxTLqa2HTgl7ZcTHYfVYl7tzOu4W4D8MojICJ9ZVkFtKvQ3WTYe+srUSGNtPmHWOU6WWjRB/iqjyznrhatURmKHJ/GUFTG+MtNewguqKZzlt/KwoICkkdCIZ73pMHO/Zv1C0ZICkoMrU8hD1lVisGBuLsT71AK8tqrvUrmZvfcQjd2rsvYEAFZhH5uG1pqE5gAr/JBYqbrgDLDwJj9OeAULp+uVDimm6uxa+i0bHgAZxLt7BjDZlssGw7fmU1QwgV3csx4PE5czQpILTFWP6PlVoztZqqoikEjJnOTaLZYJ4q1ze888W1HOLCmYz2xWyWzJtxmtBwvjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnRxDcId7MRZ1CkIlc4WIat7D1m34xRU3B4i4ynZ5ag=;
 b=s3MbVHeWWHTOmlsSRAhvErzJpqs9zogIxQFMGVywfSJ+6xvT88/qKQmOTJuaFN1nIxcPZsc1d+twGpMx8W69CMWRAL3Ee352d1VetAdvH/oZ9P/XYOqvRASxhHoVY92Z8M+q5uC1vwGvf9rt+p6/A4JeyACIX5Jil1btPSCu4oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY4PR12MB1670.namprd12.prod.outlook.com (2603:10b6:910:4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 17:19:34 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 17:19:33 +0000
Date:   Wed, 23 Mar 2022 17:19:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 01/14] EDAC/amd64: Move struct fam_type variables into
 struct amd64_pvt
Message-ID: <YjtWnqnH7ytG2K/j@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-2-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-2-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029009a4-da2e-4e95-01e6-08da0cf14c77
X-MS-TrafficTypeDiagnostic: CY4PR12MB1670:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16701E7ECC0747352B7F9857F8189@CY4PR12MB1670.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3b0rLGRHFTuZtmWtE9mWW/UPAwJds+B5r3oVFAcENa8YBEAhZdyk8USRWd7BkOPvtbojavf75SbHARcEpj+8SLbDTC6JKti3cbkRS40BuHGwb0R2eILNVEZDkcOeV4NyJ7EJd0sgCT/Alpf4eEbWFSxwWtrASu5r2BDajRjN5iEFj/zMzUrEuK0yt3kBTQe1ZobfCLGs3vQrvb4vDJ4MjtCfI4FZOHer3NlcH1OtaAqz5vTXVvvb1clyTqzSimnxO0+OBO1L2DyZqag7+/5LcK+FJYXEjvxxxeergnfPg+ipImfCrtGEzTaitbj4tuB2l45AQ3tuUhsS6Sl8cGftAuV9hVwqgx54zaaZ9TrIxM0Zt8V4ZtwAc+tW2bY0BpE/6i+l0iWww5ga+gKCpycyw4s84ZldNa80UGRj7/9/+AeMwEfBkfAbZR/TGOaRJu8X85QRFWaKznDXuVsVLvd2R8xJVZNL/qo1wpBeLFA4j63vglODttVmtD1qJLv25EZEckI/3Hbir81q9kBsLAf/X5nfndG6as81yWtwbxN4aznLhm3bFj/3/6HNCLagBxGc68hJ/C9R/Dcsdl0iif3VmOzYiMg+zr/lgIHk49GUvGDS1JZSMm1Qkq6W6VTQKJUrs7e9/kaa0eMp6p1vb3Qkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(86362001)(6486002)(6506007)(9686003)(6512007)(6666004)(2906002)(316002)(508600001)(6636002)(26005)(66946007)(66476007)(66556008)(38100700002)(8936002)(186003)(33716001)(83380400001)(5660300002)(44832011)(8676002)(4326008)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCXZi2BKaqyS0/eNHtXrHZxjIt2DkSJEleru7n3TqNr6lPkXtrWURl71sZ20?=
 =?us-ascii?Q?3RWu/4urW65wXcb49eAkyB4Vrg7dqj3ER/JIjG2tPKp2RwBcQxo+rUU14lXz?=
 =?us-ascii?Q?sJGH0yEEjIKUDpf+iMVyMQWv73qToeRa4tOexiA9Ajh+TYIOs6zvaV6dbWRu?=
 =?us-ascii?Q?RFt1v47fiv0OksZXGY9/h6Em0OMCdP1emfB3veqYXCdBlxxMDMNobHybGYWU?=
 =?us-ascii?Q?tXMDU856WOa7ZXLRMmEsekuxYYPqeL55Ic7TMgsyAF06T335j6RMHzbmCmsW?=
 =?us-ascii?Q?te8sYPHFNpj6ocW9iJtzHlIqgWJvVlTrOauSC+ONiGgQ7dEIYKNX0m8iBZrN?=
 =?us-ascii?Q?UrnfUW9FKnV7gSxunfaieqlvvt+sYdQucaW0nvhVOlZk6Yhw9TthNjKCKUqt?=
 =?us-ascii?Q?qMmzu+5BEDGtDzsjQvS770HpmepTvNXt77BUOgjwJQvPM+W0KvU9qWxOy8RV?=
 =?us-ascii?Q?BRBqqp1PO96idI0NqqYusN2/mhnLnOvKM4QpOunTpoVnLdBsg7RjAQhyjoD3?=
 =?us-ascii?Q?axe56q0P/IP3y4w9Saq2esYO1Kmi0BWGMf4PblHybUNsC4YnPCMYRyzq3KUO?=
 =?us-ascii?Q?+s7kWE4gig7BJ4itYNpzbPNlxWC2pBuOQEWDmkFuuhxu7b6MPSXjBoEnF7Lf?=
 =?us-ascii?Q?gSFvoHwAdYZp9GWuqIeqb5XwDf+SUQkKEST48dj21jkzKlbwU3ohbTdS2Ql1?=
 =?us-ascii?Q?4h814vBf/CVUhG+dQ0I+xaBxMZ7d9nH0EQMsX/SCb8a4vV3bDOGN16iWba8o?=
 =?us-ascii?Q?v5NiSnXGu7dp8Jgm5uflpvKo3QsFRb2SeRIzWi26UOXo1LndKOM6pIElbhdz?=
 =?us-ascii?Q?WBdSoOx1+t2VDNTIbpskK+td50MRHg/nZYhFwV5QUctMsdna7fWrjwgBtYiF?=
 =?us-ascii?Q?kDQ7lsk69denZiqMBbEzZzM+iOUgV1Y2wfy7S6ZxI1NzaaAATqXVXfqVPP5d?=
 =?us-ascii?Q?7FhrowHEf/dxl7Klhog4tmCtnYtrjHxHNHYLfylWXv8vDK8DbiGe0f8j81K0?=
 =?us-ascii?Q?r9yKrXUuDBrwxpldOI6HGNkE8Pe8jqo+HOGv4Y2Mh3G42wG4b+CB+2SEO3nI?=
 =?us-ascii?Q?KJQ0o4faWnuEZ/gz9L4iD4e9bKy1hsKGW+5cA/uv+RO9K7pNkGsDqKGjGxmn?=
 =?us-ascii?Q?Bpe5IY9TSJU72JCVoTkp0MATYw8AhsZAtKNh0qmKNgtU762ky3khE5z9vSSN?=
 =?us-ascii?Q?t1RF5P7qP7DTlCwB9Je/wf1jzFqEYidEleWrgiwdtFBKpUBEVwo4cs2mIoJH?=
 =?us-ascii?Q?kXLbWMM8GThXFZDShcENO6kurpHZ3g8gWaH482nTgd+xXFrm/cdKwn+Hh2mE?=
 =?us-ascii?Q?64dFnJ27NVhGZ12MMnUYYKvxv+NQLp5CBWC3oaU7Vv+h2ERYtloJCtHGwqAG?=
 =?us-ascii?Q?ltTM///ugNi5Ql544wwNbyYFsx6+VQuTiJLG2YVwxrsfFh8Prbc5b2Lu/WPr?=
 =?us-ascii?Q?hJbndugez6jpkpA9agi87tfPvOScY0EZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029009a4-da2e-4e95-01e6-08da0cf14c77
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 17:19:33.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYzFByxL9rM6h+aInp8YIFuQNvNDVdXa+CMwl3YLly1YSPaNVi5qjkmLvhbuUUW/qVGcWPNiDHHeTmj8NjX9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1670
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:41PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>

...

> -static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
> +static int per_family_init(struct amd64_pvt *pvt)
>  {
>  	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
>  	pvt->stepping	= boot_cpu_data.x86_stepping;
>  	pvt->model	= boot_cpu_data.x86_model;
>  	pvt->fam	= boot_cpu_data.x86;
> +	pvt->max_mcs	= 2;
>  
>  	switch (pvt->fam) {
>  	case 0xf:
> -		fam_type	= &family_types[K8_CPUS];
> -		pvt->ops	= &family_types[K8_CPUS].ops;
> +		pvt->ctl_name				= (pvt->ext_model > K8_REV_F) ?
> +							  "K8 revF or later" : "K8 revE or earlier";
> +		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
> +		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
> +		pvt->ops->early_channel_count		= k8_early_channel_count;
> +		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
> +		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
>  		break;
>  
>  	case 0x10:
> -		fam_type	= &family_types[F10_CPUS];
> -		pvt->ops	= &family_types[F10_CPUS].ops;
> +		pvt->ctl_name				= "F10h";
> +		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
> +		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
> +		pvt->ops->early_channel_count		= f1x_early_channel_count;
> +		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
> +		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
>  		break;
>  
>  	case 0x15:
>  		if (pvt->model == 0x30) {

I just noticed that families 15h and 16h aren't matching against a model
range. I think we should look into that.

...

> @@ -4142,10 +4012,13 @@ static int probe_one_instance(unsigned int nid)
>  	pvt->mc_node_id	= nid;
>  	pvt->F3 = F3;
>  
> +	pvt->ops = kzalloc(sizeof(*pvt->ops), GFP_KERNEL);
> +	if (!pvt->ops)
> +		goto err_out;
> +

This should goto err_enable so that pvt and above can be freed.

>  	ret = -ENODEV;
> -	fam_type = per_family_init(pvt);
> -	if (!fam_type)
> -		goto err_enable;
> +	if (per_family_init(pvt))
> +		goto err_out;
>

Same here, but pvt->ops should also be freed at this point too.
 
Thanks,
Yazen 
