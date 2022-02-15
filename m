Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218744B77BB
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 21:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbiBOQ7M (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 11:59:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiBOQ7L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 11:59:11 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422CE6C33
        for <linux-edac@vger.kernel.org>; Tue, 15 Feb 2022 08:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIGYMzg0pEZBKBga4CBcE69mBHeUxwQJjnveSCHsI3h3pphRD1tI3/OR7l7OfamitfURsDLkh01cnjI3QN8ECRysd2mwFRYQp9zri/LFc1YUlixwSwVpSIVNKZ9S6/5p2toRpHLXi/+wEfOnipvmgNiIIIiMIkyVV07Cy3M0XHPxOQuBg5ScMRG1d9Jw05dj+COJ8K2w91ZbRFnpBhHNSNRReFZyUbcXOORSe/FUt2cm1APJ1M5r/3RSusvNh498IodV4A8MhTYkHsyyrxwzhWAiMMsVoJ3XZynGBkbLbHIUMdvwrTUiVFolnnugpbgNBkAn4bX1jGaL7t24JYPeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdFZ9AF0KeiWdjSpxGvNVm9tNkdKEBuTiZqJDgrFpl4=;
 b=h0OOZD6Be+zr0AhNQeTfbHKQFxFsx6pxJamO3zb6fZGoiDSBd+cTXoWGhuMdm192362QnbzdTZW7Ll9n5VLAJivm7zZAbVFXPGmht1ynzlaY0pvahLn3GAC+XSjrgqq1ofEpl/kuWcLKG/IiG98FJydke2lUE7OdDXPawylR5lRQdsEEHpdouV2HfaOvvfIC+twqffES6mcZWZaXV2INdTkAWGSP7TnEZHu0yZHMX9AAfAI42si+2BvNA3uWlr9STgKqATfxIecneyoBoE6Dcn/Ij0kqj+kMvae+WRCbMQHWz2MCVmH4y5Y1Bcrzi14wnn732jgIGOME/xS4B8f/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdFZ9AF0KeiWdjSpxGvNVm9tNkdKEBuTiZqJDgrFpl4=;
 b=LUql0sOSy1OtS54X4aPGwGtKXUW9rF9BDPEzmANelAhBOhIWTTfyxIM6tcNAvTxAcByNJCYpQQ6Frl1hvvtqzfWm+jUOulAf8jNnXdpXi+sPGHSf5c62wfeYeXYkXdQ1Fbjf931WPkQffFWNIxJBqioHX/wM/7uGKq1wR+cAoDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 16:58:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 16:58:59 +0000
Date:   Tue, 15 Feb 2022 16:58:56 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     tibor.gyori@chem.u-szeged.hu
Cc:     linux-edac@vger.kernel.org
Subject: Re: Meaning of negative memory_channel value in rasdaemon message
Message-ID: <Ygvb0MclEFfDNqnQ@yaz-ubuntu>
References: <20220211234058.81443i8317qnq77e@webmail.u-szeged.hu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211234058.81443i8317qnq77e@webmail.u-szeged.hu>
X-ClientProxiedBy: BL0PR0102CA0028.prod.exchangelabs.com
 (2603:10b6:207:18::41) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52d85a4-c0f4-49da-9ff0-08d9f0a475b7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4196:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4196E72B631C48C49E47C1CEF8349@BY5PR12MB4196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7m0eB29aog/O6wTu8IGt2Crn6urIqXD9xXpA4//9PtWhU3vznKTSHVzYyPzAYw+iSZRrtu1XEohernhI2g4LVKqY7W36ep1GEyXJczYNXAvg9ZbnWSX71AmhNqKXokkQvRp81+w5+rfUZU9zI0XRn5VMRi5i+w/pRy0zxrUmEWJAFu4M3TOSyw8K7JCiwaUR6NBpQE8F5RKJZaukiuZ/BeeX/DmrJLVMTo0ei98Xcby5ZtVqAP65CEicXS8/KkBY4dfLPeHEjQWtT/T3bTGe7xe+OJGzKUqwrtTuvkk0Q5poCHYaNeZH7h+g/AAIddZXHV9dwv5gBP0o76aD0J52ESZIk1Ef48+goM7PNt9h24T3krOUGGKqxYJjniXhGLYxWAfy9knxsJ3hm2XvX8+Y0sFI7NdQcvQXuJRV1F4tOBQYIlTZX7G+d2pwydEto/FEb+KGgVf2A/aczN9lFGLNthFJUH1MBLRLH+bMDx+14ghgxCWQX5JDCxFSNNgwOYO3H2TFdKQ1MywIUeMQAGYHK9GdOW8CoNSZ9gPD5iwn9BHV4GqlHKBkOnjLImfkJYZUK/hUqGGz7DPDNjeTUYW2Xl8tDMVeclSQMDTDVHsSEWzoLb4tr4wOr4UbU+81rVsYCne2NxuE24FP6bVDcmnZvBuT0qjvhkxKGwPTFJecOD3ci9X6MbFvTRVngUioGCfNyClNf/5LOr8lK7sbR6mJoKVCVkTAFoYYNfNTLjOnRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8936002)(2906002)(38100700002)(6666004)(186003)(44832011)(26005)(316002)(6916009)(6512007)(9686003)(66556008)(6486002)(966005)(66476007)(15650500001)(83380400001)(8676002)(5660300002)(86362001)(508600001)(4326008)(6506007)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEecUGEg8dtaBQ0h2mjBMUXdtJIXo/fY6I0e5h+3i0l85ajZToYJAPbUanpW?=
 =?us-ascii?Q?qlyCdzfkQJLN5FJwhvar1p9nYjpnNij/UfgqGsUCeH+ZvsvVH3Czc5P/veM9?=
 =?us-ascii?Q?4GNc74oKVgkNq2qSI762VYVskJ47V321Pk/PXfPbIuJB3JC4QRdUq4sON5KP?=
 =?us-ascii?Q?0+GPvj/VxnSG4Hye+1eZYvhfLtnov3cmQV7Uj3HrAyuiklD6ygAur9yRR18+?=
 =?us-ascii?Q?0zu8qaV2vrLXqI4plXwPuMyOZIN2O5MXZPNH62swyYCb9fRYnY+ct4O1YO8p?=
 =?us-ascii?Q?DhZ8GBHQEH12+PC916jUocYUY2iF5Tze44AhmzTCSJ7CzYGyFslGw1eGty9t?=
 =?us-ascii?Q?c9upzcNex79g40dMGzKbi46SiYnkFOXeZCIhjqRY4Jl93K5FDNHchOOjUkkM?=
 =?us-ascii?Q?dSD8CSYL8h7YjSl2Ck7wufTBtoGjABFDsfwURqaPZUs8EgOGdlsBuLdP8mJf?=
 =?us-ascii?Q?doD1Lr/aiJG5ccCaAapdfj3BTgZukaoaHSs19il5MqKCVFkBcogVn6cQP4uM?=
 =?us-ascii?Q?rFQ0orQi9K332UEMh8UMZSU3+6TbET5ARDo0dkbaQld9eA2kZ2X7N9oQNhBV?=
 =?us-ascii?Q?ysrjSUQizG04aTQ64/grq073hV72vi0/F7rHbTj+I8+kgQOA3eivhnIpHaUG?=
 =?us-ascii?Q?v1CEAYBsil0Kfg06b5Xkj0oONO20WZbmBdy87+MWZG4WMvCXVcfelIU4qMxS?=
 =?us-ascii?Q?QqKjqkdfG3cWVq6Dwm6NTdffxr7lbqbiyYtr7ocIWRpShoZJkqE82j55nTha?=
 =?us-ascii?Q?ffdF0sY/Gsr7Re+zxnd3p6WpH27QLBraq4wIp2Ge/7ecKmLcYnxuCW3Ev7c/?=
 =?us-ascii?Q?1F0JYqrD5gOZTA+CdNbrYT2YMeUaL0YYkOLTI9Tp/iAgvObGASNFDdWVgdaJ?=
 =?us-ascii?Q?1XpjkON6gJg63/eMPH3TzNBJ6MgoerEMDmsOtgJy3CVGbbrq7PBUui31i3uR?=
 =?us-ascii?Q?MsSq/2GpNTPZFj9KZlTob04iifldv6A5OCCHieW1ccPLXiVqYa6JPbvpCjxP?=
 =?us-ascii?Q?cUvsuNe/eczaJK3PUQB5M1ig7suVmOmKE9mOI7kzy3fNvOwMi1yVjZFfMEex?=
 =?us-ascii?Q?4syXQZNFqNZARVXYUiQY2a2ItbqsirOKE5EP2ax3+OGNE9GZdqE89c/ISAi/?=
 =?us-ascii?Q?rW331vmIW975AZ+2yzMnnUMcP/oaCDJFQtyhpnVaa/JUeCrpREY4BioUTQBy?=
 =?us-ascii?Q?P1KQ7bhpU8eFkPc4m8Rd99gMQGLwJDiBoQDhV8fKTAxcktiQVxhKyKbJPbpr?=
 =?us-ascii?Q?luzlxPNo13sxfEXhBhbJGBEdgdffYrPzUnhOA8LsLN0MtMaLyL4W7UHkNN1y?=
 =?us-ascii?Q?kJkYepRiCi2sYKLPywvIMu3o3OfI5aj5cKssPn+R6d/9cusvyKrU2BXZYcHx?=
 =?us-ascii?Q?nIha30ANXSPwDh3HOOEqYVJuaDU9oVSSKORM/HHwAUa8GUDMS4ykRjhdWct0?=
 =?us-ascii?Q?uEYVdD7kJ2K4rhzIF+cUVjT4dYMKZ77aJCs6M4g95lKpu1066FggX9VJn0jS?=
 =?us-ascii?Q?IBp2cxKhjWUTXvJ/LZ8EFLHzW0TEL5q8DW83jdlLGSKOA7mzNq9MFBHgYVx7?=
 =?us-ascii?Q?N4DFKCCs3/zAu+muOZAU5TPC0JEHT8UzKOpucYHafb1AY9pbL4DtrqjgUxlM?=
 =?us-ascii?Q?hNl4VAxzqPP74k/vA9FTUfo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d85a4-c0f4-49da-9ff0-08d9f0a475b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:58:59.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCxD/10vbQNjvt2DJb6nYPl3V3/IIErrDKEicgUVPZd3KgpemNqTcIyj1Iy6cxGSBjBsG+ZWugjt9j9shUqd9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 11, 2022 at 11:40:58PM +0100, tibor.gyori@chem.u-szeged.hu wrote:
> Dear EDAC list,
> 
> when rasdaemon reports a memory error, what does it mean for the
> memory_channel value to be negative?
> 
> Example:
> Feb 11 22:34:40 CRD-MILAN-3 rasdaemon[918]:            <...>-42552 [001]
> 0.007845: mce_record:           2022-02-11 22:34:40 +0100 Unified Memory
> Controller (bank=18), status= 9c2040000000011b, Corrected error, no action
> required., mci=CECC, mca= DRAM ECC error.
> Feb 11 22:34:40 CRD-MILAN-3 rasdaemon[918]:  Memory Error 'mem-tx: generic
> read, tx: generic, level: L3/generic', memory_channel=-1,csrow=3, cpu_type=
> AMD Scalable MCA, cpu= 1, socketid= 0, misc= d01a0c7b01000000, addr=
> 2fa07780, synd= e4da80000a800603, ipid= 9600350f00, mcgstatus=0, mcgcap=
> 118, apicid= 1
> 
> Is -1 a magic value for memory_channel? On the AMD Milan platform, I would
> expect that memory channels would be numbered from 0 to 7. I googled for a
> bit, but could not find where this sort of stuff would be documented.
> 

Hi Tibor,

Which version of rasdaemon are you using?

You may be missing the following commit which is including v0.6.7.

https://github.com/mchehab/rasdaemon/commit/854364ba44aee9bc5646f6537fc744b0b54aff37

Thanks,
Yazen

