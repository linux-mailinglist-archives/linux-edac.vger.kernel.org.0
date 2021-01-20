Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170EC2FD310
	for <lists+linux-edac@lfdr.de>; Wed, 20 Jan 2021 15:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbhATOnA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Jan 2021 09:43:00 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:23648
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390789AbhATOmK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 20 Jan 2021 09:42:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buSViZX0Bcs3XV52zWgUj2xSefLoKHMJLL3k82aRiED2BjjmEvVM7DdAbSI40Oha92tSnbH3Rkdpb2x87Li7KALP0BIT/QPMFDynkYTu0FSBvhVG7fb2hN1TopVnyC50Lpq5v/FGaFZRomVL3BF9QEJgKJBT1BgHBv7aijBwJhnVsr5PaNEqSLFtBgSiEGGXq7eJEsbmoZ3d2oGMW5oZ/O+jJGdd8xzJevJck9QoP+QXcXv41eW+Mbdd5O5NCAXnAG7l6ctPGFyTgRDHGp+EPHDx1s7kZ6mX4cJJdQyBxkH3y1+VaRDAcOTASjxMyn6Sd+XC5HSBJmVUHdko+SYWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BypdH09Ny11zUhc8bmG+eIbCrNlxTC5f8hGLq4IKRCk=;
 b=JbIoIm/Dnc+eatYzWfbkpEztlWm0RIBTtfy0gYDfQx7LsaZRiU7ZL3UZsaO9zY+9zOmlCpykJ2P1ZtDG/sHZ+U20+QjOYrIYOtb3+leiNJeAXfZ8KjPNwNkGOVPzI+NBEmGLOUagCMY9eKMT6WAGe7Z5Uuol1fzaK7EfI7Yy7+cOeFIpn5wh46UM0mp3viwYC/FQ9eFkJqv3qVc3+ynQYwRFA4OqNCbNflYxLFAMDteQ7TqlG9qh2TsyQUT+X22THOz0K+qqM9OGKN24iMJCHY/wSrs10b3GrV7/Wsm+oUQqand1pvkj+h3pV9Bcqi1LtpsKXvxwdlcO1UGZWtXgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BypdH09Ny11zUhc8bmG+eIbCrNlxTC5f8hGLq4IKRCk=;
 b=IDhx0sF24TxUxSuNfLNZAFRP05OCY8csMWjG90VbsWzrRZ08i4OFkERTnrgP9keNQRNIQRDeOjplGwXlrgMlSR6EXoWxACgdHTPzlP3NCCnZ6tYzBRihviR8lxby7xRbb/dl40ME6su1NcL49xrw4UyeUNCSMBHq7TBRofG57Dk=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 14:41:14 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::866:baa9:f17d:d6b4]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::866:baa9:f17d:d6b4%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 14:41:14 +0000
Date:   Wed, 20 Jan 2021 08:41:11 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, wgh@torlan.ru
Subject: Re: [PATCH] EDAC/AMD64: Update scrub register addresses for newer
 models
Message-ID: <20210120144111.GB1385775@yaz-nikka.amd.com>
References: <20210116143353.7576-1-Yazen.Ghannam@amd.com>
 <20210118193112.GF30090@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193112.GF30090@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0038.namprd07.prod.outlook.com
 (2603:10b6:803:2d::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SN4PR0701CA0038.namprd07.prod.outlook.com (2603:10b6:803:2d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Wed, 20 Jan 2021 14:41:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a40be0d5-a71d-4dd1-0279-08d8bd51701f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3218D16D2C8317751ED0AAF4F8A20@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oj3Tp8izRGzA4Qe/pjhGUFiKpZADoS+CENHS+7E8CHCaUrAye9D36YIE42FX6R7lrimN2Cm3bJ6R8fx/qCVpMD8UYAB9acETgjlVRwxMulUaAwz2b32VDsfR5fjDUGBt9wDTDllIEDK4WGiM1QxJQnkJTT4M6jOnKq2FmifhnZsOXuyTPA7/G+UPjDKs9RqtG97hjlsltdXGI6sTLjs3HW+F2f9HPwiKtmf7bnGqrw3An7Uvhj+ksBID2j/nDDuqAcU8gviJ0/g0qplKvQKydNwaNzTHjeLuXHAR2Hkg9YmSxcKFatj8Mufqeaqpc7FwLohuGw1zG37XfH09AplnH3PqC9bc4bEkBRAWky3MsKvmqJzm9Fx2T6b9DknYPWufv31T0jwwPcePWB+6rxEizKcXswhXFaTz3zDE2jyOAZaq0bWK4SsWFhpMNb4WdrBEZqSEzfh6fX+XyAmKD2J1r6MdINJRjDZTp5qW3VABlLUJBMbyLPK4ea4MUqIfZhQ+Wc00+5dpYoSGrcawFTC41so/paVnyWpeNgbuMhtCTLxB+1KxDVmWeThJsW6/aWz/ZPjIClokbyCotdrSfn5w1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(86362001)(1076003)(52116002)(66556008)(44832011)(16526019)(956004)(316002)(8936002)(55016002)(66946007)(5660300002)(8676002)(26005)(4744005)(4326008)(7696005)(83380400001)(66476007)(33656002)(6916009)(186003)(2906002)(478600001)(170073001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QEEvgKuNbJZZQMF6otjxW2hiQq2mAHlUPXmY2/KiXVWHtmDjRnRbegdswLE4?=
 =?us-ascii?Q?R1pE4aXm1gFlHciEevNv/i3gXl9widpgVkV1LN1Kkk7l1XKfSDppiJ2WZYdP?=
 =?us-ascii?Q?uqtXb2RHNhCHZwYPTnKkZDQVvgwwdAdVmC0IVmgSwxWiWpPWVudLlzrGdFEX?=
 =?us-ascii?Q?ZUWAMqqlPVrqWc9jPOESzr+GF926gu8KWPxiziWUNu4//ZYrNp09cIJGbMKD?=
 =?us-ascii?Q?VEU0WfT6EooF7jKVtseHTi1SxRJHSdDERYkJ8tWG5aBn0rz6v6IIeTS3NJVd?=
 =?us-ascii?Q?mMoF3XMj5/fJd3JV7hzPju9WHR3bHLziA/jczzyXav1i5yweD3MZLDWWQGh7?=
 =?us-ascii?Q?75a/aF1l4n31o/LWpcsrXfa1fgGvznHhLmZpCMu3dcX+ivYGFnbbv/d8x3TG?=
 =?us-ascii?Q?ktFbObQdlM9aLtb6EDek0JfF4p2QyxU2Gxts7VOdo/rva9fcGounqkT7Jirw?=
 =?us-ascii?Q?B4pvvNep//N6N/tojhVGK9IBWlE79beINyPD/sBbbwfFX2cIyfhsUcT+6/UU?=
 =?us-ascii?Q?IkfimYjKmTeoGeRYkpJdczgF6x/XzskjciVeFjiK85CjrLgvtDSRTKLaS9X7?=
 =?us-ascii?Q?o3ohZ5dHX3r5R21t3/XlxcmhfmWMv30oS3Ej4zFfnVIieSNLfKuPe9z8o/q7?=
 =?us-ascii?Q?l9uGGma4sqnf7ImdO8G0CdNdLEaQka9dwnBl7qxd3yh/qBfpFyQQaSHaz6R2?=
 =?us-ascii?Q?Qz79Bwg6IHWLhUeNdwh3EUmpGeOG8v5fgduktXjuDkTX4u2BuBPhEbcmYmai?=
 =?us-ascii?Q?bDzamMmTteIXNXLYO0QXan2E4X96i8J+R3VMWQvvW07/GTkrVw4k0NUR6HDZ?=
 =?us-ascii?Q?0jj7QBAKUnVmVrkdmnkOJ7s1vJ1YPICHM7MhLQmgUle+dmwOR9CUlQ5A1mmY?=
 =?us-ascii?Q?PjKCCiBSxZ1pfjiU3OCE3b4DpfqAsa2s3wOh7eufTJhdHaeTNJHW+8SF2GHf?=
 =?us-ascii?Q?AjLZnv8iWof4JAP2J3c1gvNr5YiUcURIZxhvUaAbXRTEIvTx4V5fYKFbDuQ3?=
 =?us-ascii?Q?o95z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40be0d5-a71d-4dd1-0279-08d8bd51701f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 14:41:14.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYJzQAlMt+OyCNbT1J0e4HsP9sbAzmwMB/zhoPuUooUffHIBsrGdSUVs3vDzrVxR4vIuK8yE+knHzlKdLV/HeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 18, 2021 at 08:31:12PM +0100, Borislav Petkov wrote:
> On Sat, Jan 16, 2021 at 02:33:53PM +0000, Yazen Ghannam wrote:
> > +static struct {
> > +	u32 base, limit;
> > +} f17h_scrub_regs = {F17H_M30H_SCR_BASE_ADDR, F17H_M30H_SCR_LIMIT_ADDR};
> 
> Why not make this part of struct amd64_umc so that you can access them
> through pvt->umc?
>

We have a struct amd64_umc per channel, so putting these fixed values
there seemed redundant. Would you mind if we put this in struct
amd64_family_type? We can then set the values per family/model group
like we do with the max_mcs.

Thanks,
Yazen
