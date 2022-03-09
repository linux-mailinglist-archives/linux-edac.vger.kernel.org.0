Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B94D3CB6
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 23:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiCIWNS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 17:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbiCIWNJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 17:13:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD3A120EB5;
        Wed,  9 Mar 2022 14:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmSfaatjxftTZMdgvQ03WqSLg/NsJsuFXv/qAcgulZgw1qvGHaVVuXW+axzLRbzHGZT6qOvrnQeUBB7Po2lkkK+Ywuc8pz+uCaF9Lm8noNMiOtbBv+8YNnb+IpS69ZJ/ZgGsSP2EosaEQ1MtI004SnL+1c4XcT9080YS8lsOi1k68258ASKNdAg0cd4U0BqbEWvnn5EGAtbbNFnovsrdKQI3W1LP3tYcVVpnGIUjXnNZLgi0tPcUucmAzsSParwol/xNzdRYyD6rFIbXs4r0KREcJ7nRsqJvUnEyDTUYEzb8p33zGlTkTv80Dr/qVrLHh7EbMJyTyuZku0dUotwvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwbqkSeY41FbSkgeFvXkYkRbXnypiv8B9rKxotVZ84M=;
 b=brzNKEEduxpNfAl+Wain/vTp6iCMS1amJJYOEjdVHrwUvJnYtC/M5AUV888BX7g/3CVgIluENyUpnKwFc9xvB6DQ4FSFdf0P6l8dvd1izwtYZz3udEkuZct6oXE1Dq+iyJJpKiKeJRC02CsH0/tog2DE/474prU+Aua026qOopONrfFBcfvN8OJy+ERGO/f8bWxlZ7zf7Qbv61UzYiB/Hu5saxoRQlzOdSdyriA05YZj/vcphoT7P3YhHjihQI2uN1iTPlHtxqSJdUY+2YBI4XaVfWwkzWRMRTYsHRqjD3hgsb9kyB4NM2xqqe6yY+JO6erGtG4TXXZiv8S1c7cRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwbqkSeY41FbSkgeFvXkYkRbXnypiv8B9rKxotVZ84M=;
 b=ycH+Fng8JWwF7XjaPfga7sJLEiImTNONUSWXmPDTrR6a+sZPJNHyC4sbtj9AXMeM3Vy1D301hx9d4842/Auj5PajcZN85X2xHKBdMrN4/QvRrcIMOBfhOwjMiGBJRFZoav1rLIjvwtilcYMSWRAYVkJCn9llzv2OIZmdrJPx3Bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB3748.namprd12.prod.outlook.com (2603:10b6:a03:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 22:12:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ad74:927:9e6:d2cd%2]) with mapi id 15.20.5038.029; Wed, 9 Mar 2022
 22:12:05 +0000
Date:   Wed, 9 Mar 2022 22:12:00 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 10/24] EDAC/amd64: Define function to get Interleave
 Address Bit
Message-ID: <YikmMHYpdehehD9F@yaz-ubuntu>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-11-yazen.ghannam@amd.com>
 <YgpGyceWKsIVYuGv@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpGyceWKsIVYuGv@zn.tnic>
X-ClientProxiedBy: CH0PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:610:77::7) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f825df-b3d3-4cbf-3b87-08da0219d859
X-MS-TrafficTypeDiagnostic: BY5PR12MB3748:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37482B1A56C3115205600296F80A9@BY5PR12MB3748.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cD0pIHEBA1PLRXx15dOFbhWTAdyRXhHZorrCBwuOStAMpR/BSYA1+PrceSTvVQOs+Z6yKTruYT4jcZLwo0gcerHwouEZf5d2WBgZOL6b9BytkNpD+OMS6Yl5Q1wY/OESsWxbFHXqzopC/sNhEZNeucdTOZdm3qDfBVJaHvEuObfDD7V7AD94WhcJgVeP9G+RZq7oFn592RJdEhB8HjHOuxeDr3rN2dv2itwB4p5+U7BDiwpuHjUb/W5w11F9FIQv5k4Ci58BItgMmenVXFbpfnTAs6+7KaDlFG8P69LuHs5l+ruQqtmdTzExurL5G4CqY4hwra0PMdiKjKQFQItZbt+s3nQb7SY6u+CLtyGW/ICqKYOk+BkFQEf7jQyNxQUIb0mm4qiabdsTlvM44Wvd0P3sIvWGNRT2Opl3m6eAJbJY9VS4jhpKpvP6cwrnqFBRNZ+vIClv/czpl/TonH6x88avZsgOr5DroFtx43EP1rXglgnYTLH0CU9eYhGv1IN172XkmMUU6FFrGarMt0eb8GMngey0UeR1eLXFxMpLRtU3OcLRQk5ROr0AkRwVC4i9xEcM5U+CzDVUfWq2bXCtU8q2/stEXcnhGWhhrjcC0WgRdxNn5ZeJXW2I497sjC/diYW9KQS4dG8WutKoHA4KFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(6916009)(316002)(508600001)(8676002)(66476007)(66946007)(66556008)(33716001)(4326008)(83380400001)(6506007)(4744005)(38100700002)(5660300002)(186003)(26005)(6512007)(6666004)(9686003)(44832011)(86362001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2NuzkGh/T8+pJMqBCH7VxWPhH/5uFldAO6xBLlysHQWa0byw72x24L+ABNQ?=
 =?us-ascii?Q?/MOn871c8gxrqtMLE2MUhATkBUPLgI7OZITP8SbF1YXl+SLmuVXLIffnYcNX?=
 =?us-ascii?Q?DZaVW4pL3MtLujJD4kJ8ajvYYpJZDauqLCtahSEEXepP5FQqSO9nytEKrr2s?=
 =?us-ascii?Q?tLJQBA7gi8v6QFEkEHKMdVrIPTO1pdzVx927InzNTV1jqv3Puav2ws0D6B0M?=
 =?us-ascii?Q?nvFQwsj2ag0b8/Dg8xgDsk26mZlJ/5gcLRL75I84E4EHhpzSGetHrKuOPdle?=
 =?us-ascii?Q?FUjk63lQN351wur17OHPxFzxhrRt/v+f+uzCh2yiGMBqENf6MBnmhX3KLHLp?=
 =?us-ascii?Q?+4cHmsgRpCZJ56U59VHWZmHH826KOWeLT+rnMWFXjoICtsIFmug10yy8RNSQ?=
 =?us-ascii?Q?8tJ2wM2sxg55E53jt6k4i4gycs1/i1ay0T/PSO/IAKHMZ3KsGo2E5YJi0gBM?=
 =?us-ascii?Q?rmgBq7RKwzTQvsC+NMtMp9V44FQqSy+CI/1kmH11HAcG2GIrgx8O2b3gHmGD?=
 =?us-ascii?Q?OpzvrhEIWWA/kKa2Nl8xYynfOZxdC2lOT5F4HGulB3mGgdvsO/StpCKkAw8M?=
 =?us-ascii?Q?rc6mCahb5Lw3ndiN4lySnKrpUSVYlNXuyz/G8rC4NR/MgPoh4BZYT+sbR2/2?=
 =?us-ascii?Q?CLHHf6u8K4v9ba31RHp/WybJS/m287P8SieRt5JKe42BbjE5qnM9PH9S7xD0?=
 =?us-ascii?Q?shyITCDRALPhaeZ1jEHtQtgIU+JT13NKAg2uUY+fRaC0juZoemR1TMdli7Xn?=
 =?us-ascii?Q?DNI4PNN/47nj2PdDLeEy3z8FpRh/VfoT9ISBf+dMoSByILDhGccBnlC1ZS24?=
 =?us-ascii?Q?vGdy+oqRCHmIZYnT5MXoETHDMRNk45oD16JI+EW4hK9M25vaTHfurt8pPf4F?=
 =?us-ascii?Q?r8dqFIIMBPdw+2UkKwyOEZIHvK10+iFXfKO8g0HU8xjDj/XIlfSibnKQvUyd?=
 =?us-ascii?Q?YOJPw+NO96igTjYEM6GSdiAGhRt7F5Ef6FzzvcOpSozeJru4uJzCp3yf8SJv?=
 =?us-ascii?Q?2+EiirWfV86oT8Ipbs18UfGz3VtrD5+5DER0D3U45Y92fG/wDOyCVZ4Twv3v?=
 =?us-ascii?Q?O5eom2a/DiQ1wpCHe7Jc7ECS2kzFQyJcTkucrsTWCsv+aSy46kRzRwYxaEOO?=
 =?us-ascii?Q?sRsBcydOG4yUVph6pl/b/yEE0pdIBkkYs5IxjJrYE3wQW/rYPBA+wSD9GDrg?=
 =?us-ascii?Q?OzYVpIXGD7NAeDNxZzVulhW88PGMLGX2HsiOYXfNsAFgX/dhIBKLXb+0cfFE?=
 =?us-ascii?Q?4nhR4vGlh22qdUoGAzQUL8Bx7CUMvoGauc1a1DQ25kRcgoxtiTB74eZMSESP?=
 =?us-ascii?Q?guicEfZKiMBMf2ydevMBYzQvYb04To+eXpBkYQTH5fxLBhWqR0W8LP6BJEEU?=
 =?us-ascii?Q?R1cA9LUyLeNwwdm7tksiiFPTw6GiRe0kN0qsS7KLMnnH4K1PfH38B71xY5s+?=
 =?us-ascii?Q?7TwNMJTfgc4i6KCR49NMAqzPyQPL6jAbUDCR8a/3rxrXbUnMWR8gw+0sMMNL?=
 =?us-ascii?Q?auyNd9vWuu5JciqJW2N9kd9mPyVHE9ucHdO0PW3n65aWvtxIe7peKYsCvRLi?=
 =?us-ascii?Q?/D3oP6rrxfcRvE0d1nNBQC9G/OX8DyjvjMMh7O62ZfZ7uw+ZcMFvC4W4Hn1a?=
 =?us-ascii?Q?UA05GTbeB+ePsyOb7GmcYgk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f825df-b3d3-4cbf-3b87-08da0219d859
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:12:05.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UO+H/Z+T+FpAPGECzgugX0R55GEOVXrrD+YXKgE4k9cpCLcSKErUFv705LGhUm2SwJbN+7lsONKJbpHCK4X/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 14, 2022 at 01:10:49PM +0100, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 08:41:01PM +0000, Yazen Ghannam wrote:
> > Move code to find the interleave address bit into a separate helper
> > function.
> 
> Same question: what's the point of this change?
>

Yes, I'll update this.

Similar goal as in other places. When the function seems sufficiently long
(subjective I know), break it up into helper functions.

I've been trying to decide based on logical steps. Do you have any general
recommendations or rule-of-thumb?

Thanks,
Yazen 
