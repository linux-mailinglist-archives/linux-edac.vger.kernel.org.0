Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5571D5708E8
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jul 2022 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGKRdA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jul 2022 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGKRc7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Jul 2022 13:32:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEED06559C;
        Mon, 11 Jul 2022 10:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrczYPLbPBqAbGEdvEkF8gKYQou89iCOiZRdN4A8KDVz1T32N1pRLfNAUKLY4K5T+ziYjWGPSN3IQG+ynAZ+scMuO/9Sqf067V3qf8qGce1/rx33BYDRV/UHTfKRya9iy/h+DGflRlH9O2lFyd6N+LmvbJgH6JMRajbU0gM8gb53jTPE/BfsBGQ94ACE5km5INf+KmgKc/f+ERKF+AmYZCEkmeC+YFn75ftDoYZjJ6F9/Gdl6tiXgVz/lZS/0vTeOuFV+J0iXYghg/ytQHXLg7ItofkRag1l5QxCsyJzF37Z2AZjZyjtwlewo01QSFeXDNza6K3iPNCFVgQRiqUtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUs6mJCmefsaukeOX9FylDwj04XRdUA0zUPsmOuwR/4=;
 b=a1KoEdED39AhVCM9830PtiF9fPe3TedFoPMFWAOa9d6Bfw1Qt0D+WZ7TVJT0yiT1mtGQjt18M96BdMu/65SbH9PqlPrA+wWvnkDbf+tzUrq+ivQbIKpeRuqmJsVe2BcQCxTuHcuLZudaNJV8pysKNG9OVT/a3EtdXm+MQq8/o1jPKPTdLIn4N1tsgftH8ugDQnqDIKL2IBBFo+oRmKGnP5OQ8L0TMPJ57zea4/TqWe/MUGOrjGH9B8iPddf1Yh+hKmQgizbcF7JkIGOdnerIrZuN7j5A44XGmTqEdVQbmKB1H1mxBUvl2Hoaajnn1znaKYp6Qr+cdJAK0xYSLaopRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUs6mJCmefsaukeOX9FylDwj04XRdUA0zUPsmOuwR/4=;
 b=Sc0kyB6VkGBteq3UtPM+EHIe08jIaXucNGb0vEJnkd3VeujUer3izuYDuxD4HN4sLnblKEKHM2/Rd4Vx4JZuYhyD54xAu/j89hy23FxZR0b43lgVK12v95c8dsPQAiMPGHbCPYG8bl33kcQs9iyO6dlwQZ9sutf1ikUzzHZ2RPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB2732.namprd12.prod.outlook.com (2603:10b6:5:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 17:32:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c9f3:8fbe:281a:454e%3]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 17:32:53 +0000
Date:   Mon, 11 Jul 2022 17:32:50 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 2/3] x86/MCE/APEI: Handle variable register array size
Message-ID: <YsxewiVm5Vrg4OId@yaz-fattaah>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-3-yazen.ghannam@amd.com>
 <YsGL4JbTGF3Rcg9G@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsGL4JbTGF3Rcg9G@zn.tnic>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d14b8ff-98ed-436f-c278-08da636362c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2732:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVR+klXUp/+GTl1dvtjbksgc1RZpxx96dwomebV37gEshB4WKI7c5HNVIS3GQ/LOz687tCdnz4TuADFJ3F89Xi9HLEi54WKrvYmvtTg7HdloeNqpZ0VUWHvK0aJ5UIFJTN9TUU4KWgeYfZmpR6utq0pCWzZYw2u8xBoPkbXVpvnqaD5+628edfHsxQHfe/FigPFcnhcYaqD8+kO9mPkKzx7B3Q7G6mPr9vdF3onmULiC+vHFwq8nmzUmu4K3z6prn4HRA3qCvzmyEYVZWq4hg/wDrhidQiTIdO1CgVwyt4eAx8h+dK1S3+lg2EnqFfpgWgTJgT7bW4UnTLv/LTn6L0e+cRw+vJstR0beW+p3x+yIcHhYpayczPEdwwmBa+ImmbgE4OedI2FmCoftxteLDFtSsD7LUzd457hwRd4/ENcTJiOql8wu3VgAmxE0mqBspWiy3qQaQss8EjCg+1l29RwjMhLOfEF0NVqV+iL2R3xrt7zQiDwTVTyB8NytQFIrM9Opd9ySPKHXxqMbqr1jo3WQDk0a+7Ew1kU+pgFvIMOt56bEl6m4LsPJb96b8HiIabh/CM5/nHFVLNZ5DUYt7tpGeiJGkzOH6Vj+2aBdnc0nvD9lOod0yG79so8C4dfWx4d43nOUl1XDG4Bhd552Y0cXstmsQR/+2uRlfrIWc9lrgGYi6OREev4nczh44ts9B6EsY/7jnRv/Ox9tJyBALijGLOadXL2MPByRsm0f0eo0hGUHW5ao+S5NJu26S1MXHID9gd7QIx/do0REBVImcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(86362001)(66946007)(8936002)(8676002)(66476007)(4326008)(6916009)(6512007)(38100700002)(5660300002)(66556008)(316002)(6506007)(26005)(41300700001)(9686003)(6486002)(478600001)(2906002)(83380400001)(33716001)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGLnGGWkWF9w/uP6PZbYBxxDhlme0eT2amAxf7asZEzKWJm0IKpQWRXYfv5P?=
 =?us-ascii?Q?zcS6si/LrXNoAbHCSLNtP4+iMJVo9KzJDsTQzR/NKLf8USf1QrAfiweRqBEO?=
 =?us-ascii?Q?DEhn38Jn6dNMrRW1Q3kjRXNkcL5PEGP8kcmcpbiIurT257NvyzGq2VEZMfgJ?=
 =?us-ascii?Q?Gv93IrFI3yOpF2hAl/7TuhJImYA0Y1NeWSctDk7yfuPd4v8AIqmSbqDjp59K?=
 =?us-ascii?Q?/g0NYhlmAKNYAzkqpS2z0+N3L5LFFRDIJXN8NCwsdo/PBw8qmyFH/j9Zri6l?=
 =?us-ascii?Q?fXXbetNs4PbGsOPs0gt7sytdP9qidJUglnHnAZlg7GrpNILMc1HcHVVglhh6?=
 =?us-ascii?Q?N3O+c85aHCCJKfKrgJj9D5kvGwZM81YfhpL+YuP7UDpGSgAqqNxSLc6YUdvw?=
 =?us-ascii?Q?p19aAo4UJliWzgFmjQAMnwWRdlPCZmZBvyq1QvSvNJ6XTaxKlcaiO47PLD3i?=
 =?us-ascii?Q?j02JOy/SdOf+sQ8Gz2FoAUxzqPxpqYuerX+KF5ocekfptwKKI8K1GJR9OVb2?=
 =?us-ascii?Q?2wnrCsPWuGg0HPpH2Z5J3NfCnAqA3Y/D3LLmspdc/JZD83Zzl5X3v8IIfrNh?=
 =?us-ascii?Q?QahB/Mz/RUkCbYKDUGH2dBCf+Kka1O5/f38CG6Q/tvaRjMx37XigkMOLpToI?=
 =?us-ascii?Q?JCpDT+hRf9N6nPHcYKt0gilMme+3ScT9M8pexR+Uo7LyAdNsFB3gvmaN2Soh?=
 =?us-ascii?Q?ydEmAYC0O9rJYzBrhDhEYCRdqtSVHcoZ/EUCdLPoLGQ85sjLhRWjkXqGEec6?=
 =?us-ascii?Q?GLFRRiJQsZBf6nN/YA19iS9EEavLjJvWB6OzqN+2mqDtYnUgcify0MShY4zi?=
 =?us-ascii?Q?6sJ54p5j/ovllcxwmvtBYbz2Veyc3eb3XoDkK25jdprEGvytAIsWnRQPuq3a?=
 =?us-ascii?Q?EVMofbHHuNl66fou81XGRgbCELojh1jNYCgIlffaOS9dSlQBwwTtXqR2isWP?=
 =?us-ascii?Q?L2cQNKIlOg8IYAWrQvYA4xsr3qBELCrzO30pFAski5uBPzEXie6PeyzHyTL0?=
 =?us-ascii?Q?cwqxllu0SyOw8b4dZEuDTqway3e5lmLabe3InCubz2X4OOS9cSEQ4DvvqKMt?=
 =?us-ascii?Q?bQhuQD4j7XPV54lsqdcq5BGijIuxEOVmnH+IHkaUA92ef5ooG6SC3mRn/hTH?=
 =?us-ascii?Q?xt3HE0f8pxUAr1j5wzhyFPAbwiB/AFhaoXZy71Ges8BnV9ne7VFrqALXGo6U?=
 =?us-ascii?Q?UyA+b/7IB0UT/WO7/YbQXa8abDbr35+oJOdIDfxoc+vnbKVMZM0LKrsaeumz?=
 =?us-ascii?Q?2iwZdZG3k9vOoNH1U7I/VP6vfmZP31A18TFMpaZP24o5s07nGnQsgDJVmhtK?=
 =?us-ascii?Q?NeVQbuET0INNSIJbRfPJmgHYWDU2AIg8Z5H4LYV3iIkUoUahFqXjclFH8uWq?=
 =?us-ascii?Q?f+gjmMH7hAFjdZGtQuAhR7iHCFI8OK4AmtpoLFS0o4ZfvOJIic45YLOo8lYJ?=
 =?us-ascii?Q?Jg8xAxHOdxPF4Bar7YlgxLfj74dgZunCBkbNgQ8aojqsZjxgcI6UNS/lOP2W?=
 =?us-ascii?Q?yrjhfdA8pqBJDwGpHR0hUTP6rE+oouh0VdD5NZryQlH1h3HYek0gSiUBkLZC?=
 =?us-ascii?Q?eYrkON+sf0l4pvuiEjUt76hKhpbKmge3qdOZbZ2j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d14b8ff-98ed-436f-c278-08da636362c4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:32:53.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qESBpqqNxvB5W+y6jVJjktujrKwp24BwuOQzAd0zBEMRYDZa/mBzaR770D3B6zR+ghTsKCfTd6yqw9Vgu5pmPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2732
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jul 03, 2022 at 02:30:24PM +0200, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 05:44:39PM +0000, Yazen Ghannam wrote:
> > Recent AMD systems may provide an x86 Common Platform Error Record
> > (CPER) for errors reported in the ACPI Boot Error Record Table (BERT).
> > The x86 CPER may contain one or more Processor Context Information
> > Structures. The context structures may represent an x86 MSR range where
> > a starting address is given, and the data represents a contiguous set of
> > MSRs starting from, and including, the starting address.
> 
> You're killing me with these "may" formulations. Just say it once and
> then drop it. I mean, we know some future hw "may" support something
> new - you can just as well drop the "may" thing because if it only may
> and it turns out it might not, you don't even have to do the work and
> enabling it and sending the patch.
> 
> So no need to do that - the patch commit message should talk purely
> about functionality and not sound like some vendor doc - there are
> enough of those.
>

Understood.

Thanks,
Yazen
