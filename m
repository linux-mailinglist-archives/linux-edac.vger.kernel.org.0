Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62637AAFB
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhEKPnt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 11:43:49 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:3552
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231825AbhEKPnt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 11:43:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyHldvIGXU2zQPNYI+vgdNl+WPBurtwYZmdkP1YojeSPooAxNjktf7B9hG4QfY5Zz9jkm95SVCgI7sljV1rrtubGnN4MP92F1nSS4anIRn5Oh+HaCwY8HLSLJryoVBTjU2cSRF8Rqit+F1l89u3hzKnaL1/oCW1LGhWwOSYgpo5jKivWkyTxkjRGRsjguuRU9Sq1w4gtZ/uUrXgq8lob9mVOyNtPYexEzfiR/tldfNeqMcBp1Kt8Yi+RrEq/iweTsb4+ZvJj4ky5YnmN9yvHECHH+q7fdSpuh1H5yQX5Cgh3pjBl7juVc8GCAGGypkn4kTvSH98NNUtEnz6FAaR9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHW8MlTDMnJFDmh1N1dn3WzaoQpBO99itouekqjgJS0=;
 b=FXkx+9+9UhEI3y65T+B5O1Vl2l/WcD0gIe/mJ90/v5YRcV+LFsSV4Tf5cmoKDeO3nhhkvc4169efGL4hCYXfJpBiotYYsRndQXYPu1pCuqA4C4o7so7RD00QU261/zx7XXmvDZmJFEsS9s483RnwIm4bWrzjc898wHYE4qJ80LWK/Ny8SuxRQ7QlI9NwTq4GG7hVWo8FMVlQy0uvRHGv2Msp7RT0vSz+z2ned82SxjseMCAL7aW3ueO61e85ZZg8YUOJDcn0r+MS9378pIbbiB0WEweL+Obn4Fnjx6kLggAtPbVoCjvloV8Xlvy0xfIk+MCXAgmNhkja+9lWYSGYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHW8MlTDMnJFDmh1N1dn3WzaoQpBO99itouekqjgJS0=;
 b=N/GNcWSVcLIEBfNneUp8gxOeZFXwLUE9jFCI7ylWVZqqCxZv+ZPfYzmnQRWGaCcQVzltI/tUlD7uwSCF3BC0itWnClxGazq4u3Mm5LSc12hvSzShEW5m4abP46j79WYjjZ25kd79sMZs7XCy7u6hoYFHmuI8JiwSGw8Y3oYMjCs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1252.namprd12.prod.outlook.com (2603:10b6:404:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 15:42:39 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::418b:8ea0:dc4b:d211%6]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 15:42:39 +0000
Date:   Tue, 11 May 2021 11:42:32 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 00/25] AMD MCA Address Translation Updates
Message-ID: <20210511154232.GA17213@aus-x-yghannam.amd.com>
References: <20210507190140.18854-1-Yazen.Ghannam@amd.com>
 <1bd2362b-9bbd-c813-e678-66119b53859f@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd2362b-9bbd-c813-e678-66119b53859f@infradead.org>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:404:f5::21) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR16CA0011.namprd16.prod.outlook.com (2603:10b6:404:f5::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:42:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9571a64-17e5-4578-400c-08d914936854
X-MS-TrafficTypeDiagnostic: BN6PR12MB1252:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1252217AD5E263B556A66E6EF8539@BN6PR12MB1252.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b94QhfmqI0ALJyZtNg5lIIShSBMZKets5baoni+G5gCxVzOt3eMw7T4MOGAkOoBwG8cMMzUc3U3NCYzu7Ij5QpZQjxpkZf6CJhWPvb1ffEglUW3rSFUIQG4kr34DFMFT4algEazDIk3yfyDKlJNGPq0mN8VfrVD2aIg2i35GrBiImS+ww5GC0o1UwYq7R6JyADQBzzQ3xQl/caa3aBEErlFLrAOVgUVpRsG9R5UUqqBVV2pHK/bl69yAmXqkUMjFNZ/pyd0DhsAEplWt1MPKAqEhe+Gn2BeJ43vW/QuAuz0/5PfTZjNOtfdO0EIN+nayCsxcO6+DLqkpXntp7bcHWWpUF3WgchD6xFrN+2GW6CTDL1UDr4Ee2uA9jQRqw32mFTpgnC1WmMB7bw8Y2644eoZHRCROZp7RCYmKAuPanvFX72xyTR2NpHJcZNAE9Ax0oqDKnCxtseK+ytIVBd9Anxzf+pWdPCXn4j/JdAXiHr/h0wHwfBQe6gKbWgAzzVAhXGn/899iKSiPCoox0ObFK899M+bSahWnPD6nbgIpIgsq4F9PF8BD43J0oeatc//2xm6XDR5+o71/t/WKdbl7CdjTWdNvSDvNuZaFEwfYmHKaNBEoxFHL5ahaYD0gQ2Ekqcs3jfdcKcGgQ39NLhi/ba3lZKD4Yj/9eDflvOa2Vww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(2906002)(44832011)(4744005)(5660300002)(186003)(38350700002)(316002)(16526019)(55016002)(8936002)(956004)(6666004)(86362001)(4326008)(38100700002)(478600001)(6916009)(1076003)(52116002)(66556008)(66476007)(53546011)(66946007)(7696005)(26005)(8676002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z7jjQIIs2ZZMV9Lj6/LoQjzh3pgzAeuIkDUYas2INUdqGA2wlaYLtFck23C1?=
 =?us-ascii?Q?2V2cFQ31aIUOp6uQcPEUPJNyn+BCOA95YmxZuyAy4Rj5jPDzuRYuuxB1+LbV?=
 =?us-ascii?Q?QBv9iQ4jsguIVnx4n4EiUd0AK46OkI3rltMV4IQ+F9uYqqIFT2WIHU9o+iay?=
 =?us-ascii?Q?B0UiprlCqBrXdK1Bjtoqlx+stb2BVtQ72MOGsGhcfZw1ZxMAKLG7HDJwndW6?=
 =?us-ascii?Q?H5OxkqmMc3cxAqYL9IjIULqUBv5h6SQmoCAgtJCvER/WiRIxKDxfjOVOiLqf?=
 =?us-ascii?Q?VX0H67jM6GR2fevdCkNP2fVkrdrQtLvxUBj+jcimy8rr498/bWNBqEVHLDsz?=
 =?us-ascii?Q?ZSJM1DQrYJJNlSqE4E10pddT1JGFI0ytCAQDkaqeBQtNdQ3uMDjTIgwEl2rR?=
 =?us-ascii?Q?qoBQxMKDjBhWHhBacAvus2UuSumFjrmYh4eUlAtUmlzSTFctlVAePbRTBAF/?=
 =?us-ascii?Q?7dDdmZyWblOmB0yzJbhgnU8RKbLplE3oCHwnQ1mx27+1kw8c5HjhjNpzOAx4?=
 =?us-ascii?Q?JLUXznGPUd0vEBM4YTtpU1aG/ahI6MkUaCzB6dQCmdMxhEzDZHOmP6XIs602?=
 =?us-ascii?Q?KiS5QDdSgPge0wYalMjw4xx4Udh33iMevnTpzXYHxF4/yl4i1HG545Tn5Afx?=
 =?us-ascii?Q?cXBD9Jjnes8moR7G0cICnUAOQYEwNzTk7Vb/RSxxJCFau0xc6Fv6ZpgZWxbr?=
 =?us-ascii?Q?Vovk94XFDGf+cWhE3vu0hNdro4dtvpMm9TbzyhBTAV9MIprBMiCTFne4onwX?=
 =?us-ascii?Q?Y00pMcn4puuss587esy/QU5NaX8J5XUympL0965JJDoPXNIr4+kpfcO2S3wn?=
 =?us-ascii?Q?0fp7cTKYt4YVDUrv5IAc/vTgCCjJPE6dtJK4ikNRVg/PhDyQYQux4MpoS+PB?=
 =?us-ascii?Q?uJ1f47gV8xgLik7Xmu1hjaCvQ50rfTMA2TeiNrBGlDNMJOD3NX9aNniMNOJp?=
 =?us-ascii?Q?0XpSN16s6HBEkueA7QAqvclqw6Gpd2UDZJEErJggbLT4Rl3MQeN2GypAjQhh?=
 =?us-ascii?Q?2+wWo/UfWyK/KN31RvZFkTKmSFuZSKAVGATcNbWE9U55rcMn4cAOmFJwwWSE?=
 =?us-ascii?Q?uTxUQSeXa5qdAk75dMG4Vxl3mSpGltkIkxrE8eObT5j7eRlvotD/Tdf6Sjoi?=
 =?us-ascii?Q?nHBtvfUQF1bystg+ysij3FGoqXjHnX37SDSq5eJDclP5STU7dyMyDKdY9cGN?=
 =?us-ascii?Q?M+nShB8UhhnyHqDT+bYONNYC3V+r/XvBvUtBvSkIo+xl2cjGUxTxQqPVfiSx?=
 =?us-ascii?Q?A/jnHwDiudUBJVDTmVbIgswe/6q2oJsJB3eDYnzPRuPoZiQE/S8WKb9Tvyp6?=
 =?us-ascii?Q?3U5egIxoEaqvjlLGj/+IiWmD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9571a64-17e5-4578-400c-08d914936854
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:42:39.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odxMc7KhFuSrt4BFG83CpNqpsz9OtPaYi+2jO3IsQHp5PGrxDmqak91x2ohoT2kvPKkssEio6GOly5amgqmPTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1252
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 07, 2021 at 01:32:28PM -0700, Randy Dunlap wrote:
> On 5/7/21 12:01 PM, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> ...
> > 
> > Rome:
> >   No interleaving
> >   Nodes-per-Socket 0 (NPS0)
> >   Nodes-per-Socket 1 (NPS1)
> >   Nodes-per-Socket 2 (NPS2)
> >   Nodes-per-Socket 4 (NPS4)
> >   NPS2 w/o hashing
> >   NPS4 w/o hashing
> > 
> > Thanks,
> > Yazen
> 
> Hi Yazen,
> 
> It appears that you need to provide a glossary of acronyms, e.g.:
> 
> DF = (Data Fabric ?)
> CS =
> MCE =
> NPS = Nodes per Socket
> etc.
> 
>

Hi Randy,

That's a good idea. Should it be in the cover letter, patches, or
somewhere else?

Thanks,
Yazen
