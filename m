Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABF3FE24C
	for <lists+linux-edac@lfdr.de>; Wed,  1 Sep 2021 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbhIASTa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Sep 2021 14:19:30 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:27889
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230063AbhIAST3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 1 Sep 2021 14:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/PpR0pPESDXHqMdeGoDqAPt40iPm6ilj4HKL7CTsWSVhFu3VtfMWW6QLPDFUp0yRCHR6knb8WB6PYULddhhxvdtoczEJeodb+Py9YPx1+QY+v3hFPCy+KmOSrCKKfxIGMz+8WfXn0oeVcWe3x7OaJvcM2jBxU4QNDm90K3tRsab5RjG0Twbw+0q1513OoUp7kIZmxAch8CsRPgQOKWLd8Oxfo35gPJ9tGAgzK4IVzZuSylRY3/PhrOzAnSiijOgZ+7ZUSnKdk+bz94cJ8WxJVVuEWDShNoyzEYKq0CnnGpQMIqQE7CPvKb9YJKtCo5iJTGqI1O//7AYygW7caoWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9n5l/tS/u7ZOPk6oHWpGFCayY1q4ZPWK0vA08De+hg8=;
 b=GmAufKG8U36pUrNUhcHiXnBu6j4iGNOlcy/TbYbzg6LU6ipyF2rIo1n9ROLD9W82i8Ru4wpYgYH25UNIpuNgNNO386wiBH/Wu8E4LGEFlh0gpcKV2cjBMGWLIF6HzzjjDdmLsmDQneHoSY4L5TavtSxViITRtFoxfufOThsnNYlTDrqmcn9MOQfQghossrc5dBAtbEE2R/eNN9sD6l3OtNXF0Hi/rpJkeyGaXdEYfJ50U4NyIikm3ezz7oiVCBRYB0qXCvo6bjg4DFHPMqJfrkmnGRJDaGm1jxLFGwIfHyq93DY6XXneW+Ui94IesgUfDLQMxCVFwMhbI+pxn0JYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n5l/tS/u7ZOPk6oHWpGFCayY1q4ZPWK0vA08De+hg8=;
 b=nczQwGqS2fRDCgJrUSs6x1hxJxu+1wHMxfUPgapl+B/scHQAeKAE5cHoZwZOTJA24/MqFW81Bl3HHJt/4YHV+Sr/V5Katvh9KHVGmqAMmVAq6Mybw1aFbUfLvwToja8SHh4H8+6vthZKvsg7iVdAqU/bbJ2SIUFYB0cvGuPJf/o=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1121.namprd12.prod.outlook.com (2603:10b6:404:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 18:18:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dd2d:805d:50ad:33c5]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::dd2d:805d:50ad:33c5%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 18:18:29 +0000
Date:   Wed, 1 Sep 2021 18:18:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v3 2/3] EDAC/mce_amd: Extract node id from MCA_IPID
Message-ID: <YS/D8poNYktPKUke@yaz-ubuntu>
References: <20210806074350.114614-4-nchatrad@amd.com>
 <20210823185437.94417-1-nchatrad@amd.com>
 <20210823185437.94417-3-nchatrad@amd.com>
 <YSi9Xbm6K/VuMv/Z@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSi9Xbm6K/VuMv/Z@zn.tnic>
X-ClientProxiedBy: BN6PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:404:151::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN6PR20CA0056.namprd20.prod.outlook.com (2603:10b6:404:151::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 18:18:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2309d4d0-964d-4f1f-5034-08d96d74e64c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB112156974CE00C928EF0E88FF8CD9@BN6PR12MB1121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luLwX+/Ym0Vx3i+N5IsLxCV6Pj7it3zZ9R8WJg1VPZ5dDH3HRL5Y7iioBDVMhZyZHfviJz1Ryhz3WdOCl2juKZgTQ8QbvmxJKP258ZlUZ0J4UNcEOff5vNMS9NeZC5fNSZId4KvHnk54QeVqPaNUGY1SLgHuV//YwrmsELDxKsdEGiQAHC/VyXv/Fh3PXNgqMKJrvqqjuPdXw7hJlZAmSOpR14gSkQM8NZKydi6kp0HdeyiVj829y68FyGv+ihWxAzYRTONz3NB+wDe1FOKNKko5fVlR4k1pvECb1NxiJTfXuAKixjrh6WPHInkZs+tgKf4SdLquTEovzsoSF+QbLxTw0IrFedZTrTOn9dSqX/Jdw/fDi+vSnbamwOUxDj2UIpxu4dSOTQDDdQjWO05Ahng5jl8vIU5zqdqmW+VYYBMvT9bnI17+86sDu0piMzTsSb/1z8Ln3yuMu8/hOs5s7zrlxnu0LTaoVqmz1WPwNRzY0r7CdQfhwzd0ld4WpjO1UpdTnZguElB6aeQYzgMNiCPMkUvdRPswRZB6lc/gmVL9jGmgTBkXJB6QTa3QyAuo9imf6bWJBIY8F6d2F3DRI9tNhrdOKAv2MWkGFIG5xXQEBFBtCqipbqSpu+SKBC1HnCgInmpwa2yNhlkK60Fupg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(9686003)(186003)(2906002)(55016002)(26005)(316002)(66476007)(4326008)(44832011)(54906003)(66556008)(66946007)(5660300002)(33716001)(6496006)(83380400001)(8936002)(38100700002)(6916009)(956004)(478600001)(8676002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ME7U56O9BxrFFxFnWPLXFRIb2iYPiEIbY25Mo5xN1FligzULwT3STLbw9BQw?=
 =?us-ascii?Q?/y+8IoXgODxSEFVXFelTEVQThMI0CPXpJuoQ4tmiGoj1HVzyRqlwkGN0tIjm?=
 =?us-ascii?Q?7IB/qLu8XZTjlt8qy/bEOdV3Da81fMMRXEXFhY75Sb4JC0cXbkU087zE5fDo?=
 =?us-ascii?Q?SStMAVuqeoEqjOh3MR+Ve9FZMBsQAPQYC+rz3dkzxcWTk2Hj0P1qj7YZ3I9x?=
 =?us-ascii?Q?XKJX3MSO2TxOJgh+2xdlyXCBp+5a8SsvIK7eb9dFs2qOa/p+wB0gKaInDCUM?=
 =?us-ascii?Q?DvkMgribO20oeaUNYfo9QFEkQKaDslUUYOi9bRw76nUT/vtwdB6fyqwYvjkw?=
 =?us-ascii?Q?4STkzjUWrJwp8MnyPe8Kk7VeEOXQ2tSUujaD7g7U7otcJDt5MzZD7FickgpK?=
 =?us-ascii?Q?V7fLjGX0/nMtmUsWiuyX6EE/z2rSWd+SYhwze+xLEq2l/VWulzF05jMECUoF?=
 =?us-ascii?Q?9djr/U7nW/1mLkQByNw/4WtgzWL5pCe2JxmVBEAIN1pUJ+4wV7xRD+Yjz8Fs?=
 =?us-ascii?Q?QEJvg1iThvKsI310q0w8nL5C+h5oOTEA/TsLEvnUb2tUKo0yJZFXagidi9wp?=
 =?us-ascii?Q?jG1PcVImI8RCHF/gYrgeUaKVaQKnk/qRqOoSyTUv4IWMMBKXW2iH2YuFSPaz?=
 =?us-ascii?Q?39rAI7MsZQW3HmjgXebbcd2EYas9Mg4uNFZluOOQKz+JXlTtycWkScRSTkmC?=
 =?us-ascii?Q?W8wnmX4OdAUTzuhEBBNTv5srRPWRIsAM4X1tsxjnZGwR5MW2gl4PZz9kpfaH?=
 =?us-ascii?Q?WJnCEbpxwi5Y2R91IBBegsamdOMgmDNgOSM4ZKVkjwzMnqUOR8nQUs01OxY3?=
 =?us-ascii?Q?JInLC42hHvR6y0KjUrb7XaXSvkxpfObXUeaJcMOja/V/wQEkbE9cXepMr6G9?=
 =?us-ascii?Q?+rch7Cp2UGtnbXT59n+L2pC47pvXin/PaOB1z9mb/kC/2gt3MVRGPDvWXFaP?=
 =?us-ascii?Q?haBBR+7GbTYrSmXOfm9pLTCsledoV4SitHCpRxlDiC3inr0Cwi8Ag/BkrRex?=
 =?us-ascii?Q?+ie2oIA21Eg5/bWb4iyCW29UauzwoqfIXSJ5V/wJduyuYcIybU7CrdMuXpzI?=
 =?us-ascii?Q?PKcAjxo/UX+S8nImwX4/t1ULOrIwd3+UcCGui0wfaSXxGwlU2qB5MUQ3th+f?=
 =?us-ascii?Q?2OkgFoME1i1FNRaYS62gxhHqF86HxTukKZAvXvVKYCJVnrNfzY5KgN7B9kpi?=
 =?us-ascii?Q?fAWGs98VDDNLbU8f8in6CIF4RHur+TxCUtB8hMAzDVBpdnoQxCPUk+vCWalj?=
 =?us-ascii?Q?fnPTKdIHDXSqCChQSEhmOGsFvEAEcAoZI9R36ejDm0ofSsffD8aXb0Arz+HM?=
 =?us-ascii?Q?AQ/YcGjZlsUff/VRhPMxNp6B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2309d4d0-964d-4f1f-5034-08d96d74e64c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 18:18:29.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SImk0aE8z5SLSCiBbBl2L7MoAxPI7CXCXCm5aGP8YV1qii8HVQz6O6VClqp/b9rQDVJn342dLSGmgilRJnwf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1121
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 27, 2021 at 12:24:29PM +0200, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 12:24:36AM +0530, Naveen Krishna Chatradhi wrote:
> > On SMCA banks of the NONCPU nodes, the node id information is
> > available in MCA_IPID[47:44](InstanceIdHi).
> > 
> > Signed-off-by: Muralidhara M K <muralimk@amd.com>
> > Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Changes since v2:
> > 1. Modified subject and commit message
> > 2. Added Reviewed by Yazen Ghannam
> > 
> >  drivers/edac/mce_amd.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> > index 27d56920b469..1398032ba25a 100644
> > --- a/drivers/edac/mce_amd.c
> > +++ b/drivers/edac/mce_amd.c
> > @@ -1072,8 +1072,23 @@ static void decode_smca_error(struct mce *m)
> >  	if (xec < smca_mce_descs[bank_type].num_descs)
> >  		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
> >  
> > -	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
> > -		decode_dram_ecc(topology_die_id(m->extcpu), m);
> > +	if (xec == 0 && decode_dram_ecc) {
> > +		int node_id = 0;
> > +
> > +		if (bank_type == SMCA_UMC) {
> > +			node_id = topology_die_id(m->extcpu);
> > +		} else if (bank_type == SMCA_UMC_V2) {
> > +			/*
> > +			 * SMCA_UMC_V2 is used on the noncpu nodes, extract
> 
> Above "NONCPU", here "noncpu", I don't like that "noncpu" nomenclature.
> I wonder if we can do without it...
>

Yeah, I think that's fair.

Thanks,
Yazen 
