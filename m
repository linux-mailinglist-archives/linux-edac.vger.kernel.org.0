Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBED3416101
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbhIWOay (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 10:30:54 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:58560
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240652AbhIWOaw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Sep 2021 10:30:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fv8rIJZwsuO3IKqwHTaoCK2kz0ne1HTWjjjbflkT2U7piYU2Yr5jxt48VByyTmWFuEDXt+tniEPh0EA6NoXaC/No7tpbnOBIKZZZjPRL9DPoVqYPrI0TJcJbU5UiZWQcJZIAv1msEP9VgoG2eGivvsWrfJP0n4NjC2C4/+NTARkpIO4Z+p7HSWRPuJsYnS6nhRyZPt1aRji5lywnhF79AHfyqviksy/VUE6fXx1QovPNNNohKkFAQL8HO2Bp5XexaE+mmgpvR7b5nV94t7f5MGSMXzLURfxUNY/rLOLDKRq9A7agksF2aOSTckVLZu1qXLWm29I9ghz5YdoX3dpRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=myZtrhH71gNE+n7GWOpnDUSQLSLbMw/ZsKhWpY9RvWI=;
 b=bW/34zpK2AncDUimHvrO3ki5RXo5Hq+XM0cBT6/2p6NqcSyr0BC2EjuQXhu6iMVJq0CgmJM+XwqH1wWD9uCjJbD3L4ncZlRLP133/Cs9dFcgPGBWNrJUIBMq7n+snjmUXLNKV3OJWc/RM8VOAt0nD4prz0sBrvTB0w5tlPZ2yjdY0mO8qU29h2I+QvdNzHiSg5RaR4Z53/yWGY1ei8OiySEzw4HWktXRUIVYCr/6nQrWsVOg7uoVL9aENnPtnSzjDm+9GcH1K5+ioSMwTkP52lQJ1tgCRhfE2V80BmHy0SI90o8mq+NTtALs+AowqEUfoKNxZih/pKgdtMK2rO3hWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myZtrhH71gNE+n7GWOpnDUSQLSLbMw/ZsKhWpY9RvWI=;
 b=0kB+WQXw12MIDsxXt/Z8oMDTqgNj6a39uP1GsMG4RDX7k7DWGHhX8AlotJU51FC/2bkSyKCYwxq51mpvz7OtAXHkDIzZ1jLqV9yhpxL7hv+cfrETLsugpt7/WfGW4+b+IEnNA6JepB344ppdSHXPZK6kiKaDJ8do4l2AgO8lIhE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0020.namprd12.prod.outlook.com (2603:10b6:405:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 14:29:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 14:29:17 +0000
Date:   Thu, 23 Sep 2021 14:29:07 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Mukul Joshi <mukul.joshi@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUyPM7VfYFG/PJmu@yaz-ubuntu>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922193620.15925-1-mukul.joshi@amd.com>
X-ClientProxiedBy: BN9PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:408:fb::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN9PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:fb::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 14:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e12d8585-2fef-4206-0ea1-08d97e9e867d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0020C467B804443AB5F040E7F8A39@BN6PR1201MB0020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHCrCMxn3IZlIrYDudQLenUVKsNcWIJuOjfNZlc+154X/NMOyvWU5mvXsWwvdGD70NfkeI04gJMQBAa79L3r9b+sbbVuARy28GSd1XnSGAiRiuVMxiXV161Q42/cJPdk60jIQz7g8hrT0sSwmPQ8c0iDnjMMjn+Z5UCIFxfrD9OwT06l1Zm+tpVzoo7rJvLDwbN1ClKCZrXgCwjbmUhECPUpV/o2U4owackkJj3E0zhiPxHEwXcI+XZQJZD6GnMw0C9eixcbhWGa72SLS9PYbR+qziN5c18BjgCKC7PD3ZZEn0jQDIOx/FXX7d0iamPkcZuvVDSUz6z5A/UCmTiBEK7PG4kkiXb/icp+RsUAhUHJwctr5mb4SGIlXxLTKI8B4xa7175JxP7/lCNjuMci80Fvz+sPyMorZbbe/NfoSM7xid0LaVCWpnr2mn+iF9cpfoTtQosA3iToBDQQVBzzCSmlURR55uAiEMmnRcCO+nOJ7a+4b4AZtkkrfdggRjBulEmW2vOw2NVjKrlL3pWpfBQJoIAy+pbgBuGOA9edrC5THc4EKbBx6fpS23FX5IonX76BH3+bw4cWXobXMQ0J1PwdIJcL0cIroL4XhEFTfU3ZErm/HXKuMYC8EHTagNmFWbCkwXVuMgPZJNYebUeVgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8676002)(66476007)(6636002)(55016002)(33716001)(6496006)(83380400001)(86362001)(6666004)(66556008)(5660300002)(44832011)(8936002)(2906002)(38100700002)(4326008)(26005)(508600001)(956004)(6862004)(66946007)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLAuCd6Dvl05kLOBCYiYt7MMCi7PPIwz7BRwW9hvPsOwKVPPGk4pbGzY0HF6?=
 =?us-ascii?Q?k3m4lXFB14l2499lGrQR/EZI/Jn7ryv31eHGWakz5ahG46lUjSvlRO1RMVPu?=
 =?us-ascii?Q?fNQxwaIow2YG0D7dj89j5DW9elSpmEAZdrGsRrPZF0QkG5nGpvk2V3sEi4MI?=
 =?us-ascii?Q?pm2ItEmYqU/oD/Jj2w2szNG52EvRhgh9bVmf/zRl+4HdL2jd5+cPdFl0W//M?=
 =?us-ascii?Q?XPDFEXU6Jlz7O0P4X1iIhiOnZP4pomL8ke/FZTB2U4mJouXW/4zCziz89EBr?=
 =?us-ascii?Q?VVJDDUsJjVJsRdRi8yx2PDrNYwg3GTGLCZc9hXbiDAmLpPY5l8d6qtlAsu9f?=
 =?us-ascii?Q?wTzxvSnWeZuikezuJEBYEe4XUaY7JBtqrrtuvTY05wNUfgu/6bKMKpPcKbe3?=
 =?us-ascii?Q?dyBSXxgYviJAHEn7obUfIpudngAPZVIrHRjov8hLESCr/nTYjZb4KZz/O/hP?=
 =?us-ascii?Q?W+ARY6q8TAU8s9pV9whxVnVqpjsiC1qyMnnhuAfrM5M1+ZGbDhzZ9liNQ6Ac?=
 =?us-ascii?Q?d+g1iOHF+PYdUqX6SAW5dNPcqjLykobTmcHcIgRh7cs0KDKHW/W8j1E07XQd?=
 =?us-ascii?Q?iMY+ZGJZ3qWiOSNtGBvO0f+tHEA3f8U/RJE3TZXz+ZyeiOleL6Ppik5i4qQs?=
 =?us-ascii?Q?ifan2LokW7SNEO16+kQ7Pgl4WT2aamUDLfeZUudT7LDN1r/w34u3UAIuKJ4t?=
 =?us-ascii?Q?wrtDUEszZ7hE3UiYwrDXrf5EhenQuL722m1u/bBXTGZ58rCb1LfkhBG+MiQd?=
 =?us-ascii?Q?6MPpCVGkBaDBp/5QyFDXWDhnBL/lu8L4EEcpOqcU4fJsJwwkw1pNysfZ8Gsk?=
 =?us-ascii?Q?oe2bM4OlD+VEur+6HcrF9wNjWohilglhNCaKkeiegmmOGtmp3qaW+l/A/qQw?=
 =?us-ascii?Q?+B/E7BIE3t03oyzHXT0C/v4seBbZsiyPBRJyw+Nt1M5in1a7QV36Xrz38WOx?=
 =?us-ascii?Q?xm13AFHqhwiWDTKRx97WFytDJVP6PS9idufUMGwNJhFc9osV39gWlRv/gsEr?=
 =?us-ascii?Q?6ZxiN4PgJ0m0Faqm5zDW10wkoP0e8Tdx9SaAilwDSDlRrb75+REnLyEJ1rHW?=
 =?us-ascii?Q?e0em8FoGCj2FmmaLy+Sb+kwGqbwtyPZUc6wM7va3u3iZW0hyZoqPShYRWMly?=
 =?us-ascii?Q?7fwBRnYf0Oqn6kIkdhVejjAbc8QaYZIEcqnIWc/xfkLPrr1NlPgsBhEJ5wTf?=
 =?us-ascii?Q?JMfrNDH9oFmvesywWBj6W67Wbm2jlZwjnCS8jsOJGwh1tmv38cEu1wfSeDul?=
 =?us-ascii?Q?IVm2UCopF7XPL7dxLgEVofJr65fOQOqpqWqWZQqyvIg3yZ83R/WjoabQC5dG?=
 =?us-ascii?Q?P/yeIbKvZAIp0WkE905a2LPj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12d8585-2fef-4206-0ea1-08d97e9e867d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 14:29:17.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWU4ZSm1Svft4YtB9cI+mrbxPsonKXQSwt5cSJ4StnxJKNMJq7QyC0Ml1LJNc+A+7h/VO9TcHfgo66FIgcgk3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0020
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 22, 2021 at 03:36:20PM -0400, Mukul Joshi wrote:
> On Aldebaran, GPU driver will handle bad page retirement
> even though UMC is host managed. As a result, register a
> bad page retirement handler on the mce notifier chain to
> retire bad pages on Aldebaran.
> 

I think this should state that the driver will do page retirement for
GPU-managed memory. As written, it implies that the driver do page retirement
in general for the system.

...

> +
> +static int amdgpu_bad_page_notifier(struct notifier_block *nb,
> +				    unsigned long val, void *data)
> +{
> +	struct mce *m = (struct mce *)data;
> +	struct amdgpu_device *adev = NULL;
> +	uint32_t gpu_id = 0;
> +	uint32_t umc_inst = 0;
> +	uint32_t ch_inst, channel_index = 0;
> +	struct ras_err_data err_data = {0, 0, 0, NULL};
> +	struct eeprom_table_record err_rec;
> +	uint64_t retired_page;
> +
> +	/*
> +	 * If the error was generated in UMC_V2, which belongs to GPU UMCs,
> +	 * and error occurred in DramECC (Extended error code = 0) then only
> +	 * process the error, else bail out.
> +	 */
> +	if (!m || !((smca_get_bank_type(m->bank) == SMCA_UMC_V2) &&
> +		    (XEC(m->status, 0x1f) == 0x0)))

The MCA_STATUS[ErrorCodeExt] field is bits [21:16], so the mask should be
0x3f.

> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * If it is correctable error, return.
> +	 */
> +	if (mce_is_correctable(m))
> +		return NOTIFY_OK;

Shouldn't this be "NOTIFY_DONE" if "don't care" about this error?

Thanks,
Yazen
