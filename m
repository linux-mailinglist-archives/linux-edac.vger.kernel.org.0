Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861E4D3CFA
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 23:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiCIWeO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbiCIWeB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 17:34:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81246121528;
        Wed,  9 Mar 2022 14:33:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8kbhRYhX30EmL5pdp/JV601JkGfHk+jsH7IB502pJNQGoDPwnpDhnrjKW25okJZPG6dSQC1usyZT/BMa62tNl9m9KN7zx6E3MbuCNXcerluE7xBsZqMe9dN2zGP5p3JkY0OrX2xVuTZy5Sjkw5eoyHIRWJKkiwhLG4eubIgWetlxoymMgHtOD8tuLQLq3EeVzo8jnJQM82G8s/ceu1vObPtH/HIDUhn6wbkCYsV7uyOZTLYPPpkdd3iE/b5dJB9yRHQm6bKVsAEa+9/b0G6u9P73GShk8iXH8+hQoNUppa/SEwbfE3IgNA/XXfePipHJTzbzM0CL+8HBr915/2lMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ2uKo0eiKys1l8oB6mGaYnXZQNRQuLu/34I1a3s3Uo=;
 b=Ko5Nil76wLo5Wx6WuGutRSKtxvYeYkviZPAAi6Kc6rd+kdTSe4svmIHrndwIp8R9PWTNeA4JU3wwxF4Ie1a8xLTuEjS7cYLz6kjAw21+56T6TxPWQCRSDh3ujaUWrBxsAjNlceXboIbgFKYAwx2Il7du9Mfhq+cJtvxS12OJawbOIdAszNEOyx8eYareCcKqFGmxBMizN+Kg7groyQ8hfh60zD8ZMuk2XDLJgMCY16yzKpQL1jryaVUJ99svlFhTWFz3eFaVuu2xQBNbnVsfZmnbDVpmEYfmzLKgNdyO0cdlnogFqhhRdaQDB5Ko/VJYgw3A0pRGJhrbEoiKqLsyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ2uKo0eiKys1l8oB6mGaYnXZQNRQuLu/34I1a3s3Uo=;
 b=PVnGxYJT49hF53+q/ZxwBhI7hjYXL6wJtCh18oAHtw8MQcvISQOr7j0YKXHG1Nj5byuW2E4zsMIEq5KQWJJFP4cE8eWrtFJyTB+vcJlxfM4c7VwFnkwfVIctqIpAhIOX+6yVXhpQWwGKMH5VGb31tpo2FK2yGIbabIghMDme/Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 22:32:56 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 22:32:56 +0000
Date:   Wed, 9 Mar 2022 22:32:52 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 21/24] EDAC/amd64: Update CS ID calculation to match
 reference code
Message-ID: <YikrFAUau/sqai34@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-22-yazen.ghannam@amd.com>
 <YgpcTDC1i6s4Wcy4@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpcTDC1i6s4Wcy4@zn.tnic>
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbbc04c4-1a1e-4f6f-c8ec-08da021cc1d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3419:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB341960F7A8FE276600D37E74F80A9@DM6PR12MB3419.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sD8QahaOYwGb/uuH6hkmFLyE/0Gw8Ds1LOJxR6MBAth4PWl6MDzurSxNiT2dxy+RTDua9CBQ/YBqLaexJWLjI6Ss5j50PJXqDtcWG9OgLLZfx6Yz4cvUqAbxQG/MY6dYfuDBjq1Se7ueipCD0stkB7fR+w2kNtalfFZnLLSboxk/pg6kIVbBMOcvqqXj+OHzUscB2+/t18oh6sYUsU6lyx2QJygT7eX/DKz5nyxbpv3/xOZfrhLlumvQV7CdXcMm/aUAGfJZEkEc3yYv5ORnmvgMUAMbWcaCcSRTYb1U/cbprBxMjBbk890QJZIedXNeuGg38n74iQAPQoTUJX94gL9VaybNOiYCmXXfOurbz2LoXg6XNvmn0RWkRWVZU9OFBFXgPuJikr9QQIq8zqPFJ4TlZHqFDvt0LplF/zGxnN5wgTkmZ1A4bNa6QLhqPlrJD3rYCvlIoOHnI58IFIeL5kyhS/8i7GMzKxw2pF9FrtjE7Yfqkmlski1yfJjL+C9ScK3glLLOe4RrbPhHHXINbpSQuA7MHOOR+Xhtjqw480yggmxaPsZiFzi+zlRo7DDSC3gFddnDWurJzf6SlQwglULc/vhndqFd/QhltopVk28a8yOizDiXfD3Pru+vQb02R6ms8A+QnubBXDMEchsHFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(508600001)(83380400001)(86362001)(6506007)(6486002)(6916009)(38100700002)(316002)(33716001)(5660300002)(2906002)(6666004)(6512007)(9686003)(15650500001)(4744005)(44832011)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MOAhfGDZNNIIfOOUNc8K2DyOLUrfU5ZML68eVL45FJd3ziWCjuTr/Brjka3L?=
 =?us-ascii?Q?ArSGXlVxuud+4Y1PUiXhuU5IOpxdGD9qKwX7Ay2/SW3VkDc3geS3WAvDkcgd?=
 =?us-ascii?Q?v4rC+G4KHPkk2eqEPv051lzSmsy3li6MTEww31yGSwfVbHFx5DjPezahwqNd?=
 =?us-ascii?Q?w7ZjY1Vv9dma4FzAAt4y5bQpe0Jj1SsIf4avaiegdHq5mLdbxIuVWFm3Vy/W?=
 =?us-ascii?Q?VzZUp7jVCMKOROOLH5PW9rHQ8b9dxyNh3TSPNPFh34Lth3uz6aEMfjPQh3Ct?=
 =?us-ascii?Q?w2PwULs52tC0XbPqjTgReUKjbRd0L0T6hi9cjxU7j8LhoUZyEIlrDp75Rq5K?=
 =?us-ascii?Q?vTsJ7+cATOUKp1k90HvdUxuO5w+1Bx1F036UyUdbO6qu9vyTfBFVPZ8wuFTR?=
 =?us-ascii?Q?SclnhVyAteTGLmigiu0levNdYYN7Eo0Dcb2XEgkN3FOqV6qgyqkxLmg8eYzy?=
 =?us-ascii?Q?nNV4seXhnRbmg/DR0hUejONlTYWj+02QInMIMb+eOmbqHWpIMsWNatQDURPt?=
 =?us-ascii?Q?jyvXUMuXesJ1PL+3p06h8iSSyDDKDsoIqBUKHqXl8t0EoHgWNbeT1bqkHqQh?=
 =?us-ascii?Q?E6/1f43Kxsha7iNNU1nopgcarR0JmO4n0G71MnjITlwSSr4JddzNmlPnR/gP?=
 =?us-ascii?Q?YuLpNEeS49Ym/NrqYRu+NqQ36K0Zdh5IveNODhpbbARnilDZGeSFJBy58jql?=
 =?us-ascii?Q?h4ccJCDjLcXC27zrB7ZhdRtlkhRZKJ/icj8QFM7T6nVQ0y9EMBsNqH9G3Qtb?=
 =?us-ascii?Q?3+Q84S59NQt3/+2VwsuJqpz8bdHKAZmIo7WM4ANHu566DKBO7hYKreNqak9V?=
 =?us-ascii?Q?QUOQtGT40QGLtImLkSbgqPft7FdRHdJ/84mGljbHzmLdQqPR/ddNCaw4it9J?=
 =?us-ascii?Q?JqrrVHfueFTbfuUMUEnJFY5uhGvH8tImti34B/2n4bUL0jsc04MecIOmrvKK?=
 =?us-ascii?Q?t9vm7oe6q6HFKeDVwHfitlRbYuABsTkkbdPRZsReyI73WvEzIq4GpeJ4VCDN?=
 =?us-ascii?Q?9MEKkxZhaf+TpaWw08d99/LlziuV9de8ehAIio+/l89zXMwH0npi8BV6hMug?=
 =?us-ascii?Q?iaS+0bpQDuT2solFiasgCfXX1kZkcU0zC4tf4C7Z7KOqLusD8pa9cO9KVA96?=
 =?us-ascii?Q?Z/eazhNdvkOMUXsCNTgJ7iqHdbYaU/g7q6Eg1wzUpbYT4xcb65V9qroFV/8B?=
 =?us-ascii?Q?xkCBFG/D/k3uSVbKbxlhZzovuHCXfgUkfmyPfGkEJyaJeckgm858d9kOLodt?=
 =?us-ascii?Q?xSu3iZ28gqju5XUuM5vbJOKmH4x36HcUtiXmZrPJ5/g/O20yWPZTNizTZnjm?=
 =?us-ascii?Q?h+XS6Mt84r8GWForNaKENnhHEZcZvPSxFJjtpybdnuQKzkcFkaI9mdDCWhLQ?=
 =?us-ascii?Q?xSko1o6mFjCpkRtSlNIiggmXGnQIxgACkWxZGknvQneO5JEtvsobYOerc8Yb?=
 =?us-ascii?Q?/0gR3eywfPUlJrtL2vdeWLtha1CUoRfJ7y+3bTf8agxgwEMEhRQ8DzWeqYro?=
 =?us-ascii?Q?CJR9rlD64/VHLSax8RQPxeHZBPaOyyvkpEd26Tdh+lMa0Rz15t2LdNr8bWCQ?=
 =?us-ascii?Q?5UZQQSVuVbmASXIqSAXuzbUlApO2Oy4/oMiqXvX8aI8iLNbcXTSpqmtw6wdr?=
 =?us-ascii?Q?+9pJepJtuH4KPae0eMUimdU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbc04c4-1a1e-4f6f-c8ec-08da021cc1d2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:32:56.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8Sy3/CRX6cEJL1a7G3wSyGll47t4jeDPmgxyuS7k+jZlsLkguHDcMeFg34CDnoYIaJMM48gmGDYeBceNcjYYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3419
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 02:42:36PM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:41:12PM +0000, Yazen Ghannam wrote:
> > Redo the current CS ID calculations to match the reference code. Helper
> > functions are introduced that will be expanded for future DF versions.
> 
>  "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour."
> 
> Also, do not talk about what your patch does - that should hopefully be
> visible in the diff itself. Rather, talk about *why* you're doing what
> you're doing.
> 
> Just a reminder.
>

Yep, thank you. I'll update this.

Thanks,
Yazen 
