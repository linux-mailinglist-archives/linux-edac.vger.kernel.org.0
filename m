Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314D04732D6
	for <lists+linux-edac@lfdr.de>; Mon, 13 Dec 2021 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbhLMRYd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Dec 2021 12:24:33 -0500
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:57057
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234741AbhLMRYd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 Dec 2021 12:24:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYn+xaKQQ9wjaQpMo4j4hIskVoF8r+uOrPTx1W1RAewVauvKSb7x1VYg/6b/47wh5eKJkdrMoW2FIzUgnDDhihrVA989/rmDv8XoleXkG0L7On+9jrIDu7h7R4jsVK3K8UWHdhBMGM1lxJhgcov5obfjlP0rp0IOtA99ouAoHfkJ4znU/QM7hqazofk4OBnAQ5/31iPnihVy7GityZVl459h8npsM6E+C9UzYLgPnBoOFsCnIdzx2mjAdOct6uub9hTiz5x0g4j73FhFnfaw7P1KQGjn9O90TPIJij3kKvXXHrud/+AmYpPCF6QGoDuTZViXxuHqFI+nY1/elRlORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0URwh3si2KevCdmqAIX8Xg/075BF1mSjUS/eDUBue3k=;
 b=F89dwvW8aWHGSkb3gxCSwiEMPc+gZMtxAhiqMGZoGyVl31P6hTHfSZY3SM6LcumFnvx4ZnpwZ/cHc8ZOoUjyKT2gupqJlXCOz4aO5d8J25uR+Lg4+CDIfDVKSNhl3U6xCRx/btzntqh/S61L9T3PCthlRH9Yil2ZMHKk43A9ziTwomKiLBXSuaOFgcHZhoQ15KCgxvavj26du9mO/xdl1x1dGOySwnjaEjw1LOrcdPxcTzlR4dGDqncCjZCgrIaVUIEz32gKHB2KzHvIJRUgQTzCLMkiOIs/mjszuqGDdsyTnRKRbQ/u+XJ03Uvl1JU/eMfz+H/Rk7qVVDqdEUIegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0URwh3si2KevCdmqAIX8Xg/075BF1mSjUS/eDUBue3k=;
 b=tkht99yTcP56WQwpKw+kpf3QbTbXWY2m1pjNY9p1bR2Zsl03G7cqlDlcl9PE8f+wHJNREYjlv/xdMKMgMpKGCSgLRIRd46tWUjAFPizwNUHwlvfUYlBH2/7msNYBEzepPD3mZIe7DTHve1Rszjxx0HkDPKQF+J1rmQ9sTcnFSJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 17:24:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 17:24:30 +0000
Date:   Mon, 13 Dec 2021 17:24:26 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 3/4] EDAC/amd64: Check register values from all UMCs
Message-ID: <YbeByvJlicfuehaA@yaz-ubuntu>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
 <20211208174356.1997855-4-yazen.ghannam@amd.com>
 <YbNJSyv4GdC+SUSD@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNJSyv4GdC+SUSD@zn.tnic>
X-ClientProxiedBy: BL1PR13CA0352.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3236763f-383e-40b2-0985-08d9be5d6bf6
X-MS-TrafficTypeDiagnostic: BN8PR12MB4770:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4770C614FC5DAA2FBC12AF21F8749@BN8PR12MB4770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPTDAfBvlnV6ChE+yLb2X6sas9vWVwFiJRECceBE/CgOBB5CXvZ9bOlm2Ym70aMJst9i9Pd+BJDDhwss/Ao2xnk+cibLAZFXfWl9zPBUMJzSEFDV3rY5NfpLHEsMuFkGb2sGG5kIWCS7UIaLxcw56uPPvHaXEpBHBwGxvPALoktQeKsTvzbq0Im7YKPNwFnG9jT599Lfpc6DAKQfKEDa6er8+Rup4Q46EmyuVOGlGtzCpZp5IyBZ4wFzjQ9ioj/yWP+w1hwHu07GPMzh1NOFfhQarsRSvnEck90lQNtQ0dxCq1x9LKqaM0XTO50VLs9MlqWPZQeZRtDGmRPMApgOqWr8GziszTYvVbHmqyR/gCXr5Tc3QLfQcgaHB9V4iTTAomBQhltbLTUJRl5dUgw+e3PZclgOjRU3tT8Yf8djpZIN+F0Q6q9+/xh7OK7lyZGEDyeXsJ3sMx6riJJliq0+IF19dyDIRurtx6RiZ0Wp81KM5vt1EYieBLB7D5YTFfNUaPtTsImBeTRzfFse9Lmywne5lS4SSWxg57jIYq+GVe2/c5LtLcZVl1QJM0cc+eKZxp1Ufr6eJnEUgEI0084EwN+CiR6mKZu6Yy+6yHv760bb3d+rkZ5rfxHCUOyHlkiqGlrq8bMqr0kIgmHfiF9NkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(33716001)(8936002)(8676002)(4326008)(38100700002)(508600001)(9686003)(6512007)(5660300002)(83380400001)(4744005)(26005)(6666004)(186003)(6486002)(66946007)(66476007)(66556008)(2906002)(6916009)(86362001)(44832011)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ulIddD0v8ZQ+deC6pxC595LRfHvc/PVWv2NABtxWNsFb7vOs4ZfHevbMpb+H?=
 =?us-ascii?Q?vZNhgOABCzD6lK9+5aFjkbkyuRyU0/t3BOm9aCkogCNKjdp68paCcA+D3Fnc?=
 =?us-ascii?Q?Lcu/Va0yIN+f4H8Hn2p2nfOGWhRSY5TAsWeE0EvzoBGbHwGdJiVP2Hroqju8?=
 =?us-ascii?Q?K/b/yy/kFMWtxpTWOAxHQAjcUsqs2v0A2lIGX+FErh0FN0W3AhKlYLP87+vX?=
 =?us-ascii?Q?D+jqibCCOMMQPiPqETWZhnPjMtFUskEnj0Ncm88+yyqDv9u8xBVBkZIL0Xrg?=
 =?us-ascii?Q?n2xE7DJBr3ve6AlzdLhsIXHiT4PgkEdPxC5CuFi+uI46VhCHVCRZKjOYOYW5?=
 =?us-ascii?Q?qz9x20xW1RPRMP/VLxEZdQImjHZ+8L+jwM65jlq+7tcjilW0soqTYAC0TEcX?=
 =?us-ascii?Q?mUSx8M4hbcVNd4OnsqUqzUTVzMm3Yi1apsR8ZpDZEWkGst1fQfkpD1YY6v2e?=
 =?us-ascii?Q?CC3Wsd1Y62CQ9GrqRhTrMfLWKJePEf3MgHU8/Ec+T0/yMB0C8QzUWWLHNx2b?=
 =?us-ascii?Q?Sb2o0mO5Mgr2l7kMyRd1eWe36MmiYKsbeIrvQJ6bnmM0XbzVwp0Zn+W43gxm?=
 =?us-ascii?Q?u1/D9R91SgvsDax9zl4s3FWPUhoylgZMPax7IJ+aNOa2C7xJvAuM+viNvTzq?=
 =?us-ascii?Q?TnmHDDt1n8qeSVBqp07V+NkJiujIt4LllNPFXv2VvijuEcH+SCvc2Sv/LjLu?=
 =?us-ascii?Q?f1euim3nA1+dq6BNMYjumrirEG3t1VJgvuSS/0OuJcl7udFTeR8WKtGgjIEf?=
 =?us-ascii?Q?566/OrcoDtMCnBWlHdEvgYb03+HMg+1GCLKSoj/VsYHkzKArfg3KRZPFbPRC?=
 =?us-ascii?Q?1fSHFEOEi1bXpwLTuRbgECmudH3sCZZ3RXN64IPPfIlVcRTwKMB/DrsITgzb?=
 =?us-ascii?Q?afEEA/qVBojoEVB5eOjFcM1WMgEBUxzz2sZlZ/fZ51tA0Sqg0Q3IOX/Q2kgP?=
 =?us-ascii?Q?VP7uCiFDKXQQESyFMoCmRiRpvLdAUE2TgfU0jrif4MUIOIQKlSEnvD3/EJkK?=
 =?us-ascii?Q?OfBIxXs9pPGqJrIgFayVDAmHnEhqKf0UiuqEiUPeL9xxn8JQBNI2p0ysIWKN?=
 =?us-ascii?Q?3eN6dyUK9iC4f3k4hRunMWPMhTsksTdH0kl5yPBZN1l68uk68c9P0L3eabqa?=
 =?us-ascii?Q?LRXHgDs+nG+q7PQD4n73oHAJvwZes+VNMxizv3hf4pzbOG5jgnt4oED8zp7b?=
 =?us-ascii?Q?5MWpiCrSD7N2TYiWNvL+vo1qR+j6Qq4awmLrOaQcAzNnjSIa8crGoZBny5ww?=
 =?us-ascii?Q?fJO0Aed1tbHzRflqGF5uYcOC3k8386mH9O/ITXIqgDg5sTk3spPGxE51nQO9?=
 =?us-ascii?Q?GOETXRwYeczTbZ2oDNdminLO24aKkt3kmqRawPEo6IdOUTXGlGdvjG70csST?=
 =?us-ascii?Q?f5WK9ztf9x3Ft3oMmwvD7uzeVJ/WaUW6PtrSx9wf7mWRqFT0fH+gzfR5L76N?=
 =?us-ascii?Q?YbX5ZdMOO0wizOEqf6hoSvmP1b+GS3AdACcmJqwrRqKO9v257buX11UrQZBd?=
 =?us-ascii?Q?B8eDP307vPXI9mJP8GBpQAh0OsCAv+l6lXir8+7U3l38aJbIS8u8f576TyT/?=
 =?us-ascii?Q?dLrHzwotlfHdLw2TDvSc2PYWrHREqU4VxQf0z1yoUnORsGgbLz0LXWV8331C?=
 =?us-ascii?Q?DNEYIyyx0VTbKRnIn2wJ0r0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3236763f-383e-40b2-0985-08d9be5d6bf6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 17:24:30.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ed4ICSI6vOiC99mztyuMcE2jDm3SLIUnaxXZW8csr73u2Em8Nvg99tBXleAPZHSw+p/G8tVwqm3JTw1xUIYQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4770
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 10, 2021 at 01:34:19PM +0100, Borislav Petkov wrote:
> On Wed, Dec 08, 2021 at 05:43:55PM +0000, Yazen Ghannam wrote:
> > Loop over all UMCs and create bitmasks to check the values of the
> > DIMM_CFG and UMC_CFG registers rather than just checking the values from
> > the first two UMCs.
> 
> Do not talk about what your patch does in the commit message - that
> should hopefully be visible in the diff itself. Rather, talk about *why*
> you're doing what you're doing.
>

Understood.

Thanks,
Yazen 
