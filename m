Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05C74A9C3E
	for <lists+linux-edac@lfdr.de>; Fri,  4 Feb 2022 16:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359845AbiBDPvY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Feb 2022 10:51:24 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:15073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230391AbiBDPvX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Feb 2022 10:51:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWfvWagBfFXpp9W7dxqjeVPlUQTaCIw3kqd9+2T+rmQt3ffSyXNpmm90Z1n4gzTmojFkQlWonUWMdsYjtYMVsgxl5hvZdUboe2e7QYNy+iwFWLa+l43l4NXWKJqzNouM/Nl3AiSTKVRZGPqX3QsipIjhJb5gPu163NeaeNfJ9y/0/CvqfJ3xq51kd/raVt6oV9p7XZrTNpW+Kh3rz4ItLinl+cXwmzuCBjZroLoVSDLedX1fk8uPGXA+VoQG+N0Ko/hCvqzsqOhn+Hwn1gb9sjegGZ6/5wHxbVKM2pS/IEpBo6dD8jXX71+u7v8fFP4jr9mtAVdIeDPnNS/Nqam/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k54aRO7VWFGVJ6heC8WGRmyImIUgIf1hjulhl55t600=;
 b=DKNfo2pYG0oZdW/iLndNMNDIo+l1jZh4HbSHgWJ4HP72GdHAKeNE6f30Mr3iUMuLbGmyYr6gQYx+di2UZ6XX459VfRRvrg0n7yFVPx88wruwHh7bArv0e1IAHiuH6uncIKqg3hD8BA6BgdFAjR9fDcBFYRo+GJrNglFXwBHwheIxsIl5hgGBlgFD3kygUnZk4yc1X2S3jBmpsF0gxJQcs3LgWbfCGzKbV/g7szIPVV9E7vLLp0DqRHo3Eo17ez2dbUClCF2cVCRHlF8rDFwImzLzVpCAMNmhLlqSLNQKw3nbANDwuct6sTG5derPuLwodi2qdJO1r0IEpW8X/MZTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k54aRO7VWFGVJ6heC8WGRmyImIUgIf1hjulhl55t600=;
 b=FPQn7aM7DCr2YbNs1VRpHpPqXE7W+oITU8tFvN3dmB+iLs9eKq/T791S8p/TcWldjh1H/z/Scfy0J5f+IjBTOgE+s0bTYammELawfwlANB+ePPp5TpvGu3Xu3E1a9vBgRDw7qQCcFWsmzEodoycu7jnaEs6I25EVovn+g60Lgqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 15:51:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%6]) with mapi id 15.20.4951.012; Fri, 4 Feb 2022
 15:51:17 +0000
Date:   Fri, 4 Feb 2022 15:51:14 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     William Roche <william.roche@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 1/2] EDAC/amd64: Set memory type per DIMM
Message-ID: <Yf1LchOlECslWK2b@yaz-ubuntu>
References: <20220202144307.2678405-1-yazen.ghannam@amd.com>
 <20220202144307.2678405-2-yazen.ghannam@amd.com>
 <a42a7696-0150-6d63-953e-adec19e25d02@oracle.com>
 <YfviHFrzzdapbwDt@zn.tnic>
 <962dc65c-6e52-bf02-5ba5-7e8731442390@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <962dc65c-6e52-bf02-5ba5-7e8731442390@oracle.com>
X-ClientProxiedBy: CH2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:20::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2531ac-c288-48da-23ac-08d9e7f62e50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB125848373AE592441CA34E7CF8299@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyKkloa4GUycjFpoWwtAXhbJfnOrZeAOu/glE6LnmzlLPk4sR7v2tLeZzNujqG6q6u4u+cUcsh5cyBUcF0koXWZ8dFdxFkLqVTC6ORYUBbo/8Hq+8aFMN4Hv5ckZii2d6Yjhuxfvv1Yl/1NvC3uMV67Wz4/CH3YYrwQQY7jXVY8zKbB2RQq4FSToW38GpE+OJeq/GyB5K2qTOvz6ZjSUKRYcKsH/NZFkBQR3WDdCOmOIFoisNCYOItSqd5KvD2jGGTeJbJrdcFejYb7uQga3RBlcKpwUGELGv1Gf6DX25ZYpRDWh+/DuQEN99FAaBfHn/0WBLkIc37Ntyz88YOleuF3DhpgLBoeMQWSDYlSAv1I+sscHy3ZaxtBZisD2+JRxIjQlUxOQH5HZDvdcSJXf6mhhq88xHjZgPT2Ff3hnqB3xUqb0A3x03rhFL1Z0ojELPIdhqLOAnvIiYtCFheT+COUpK/1K3bVO7xfmi6r9UMY9kXvQExHYFkpMdiCfWeRydSXn41iLrngD4GaKqUbP2ds4Sr9jj17ixnAiiL1/MkJxQLVZXzogvFeZZj560ir1Aw9Xxatp/kIYtX5lNb4jSsS1s5Y1OFzhnx99j1yjNK7SWwIZbAUQncAyJ/Khaciy5Ee1g8vQ7e2u1W7DP+jcVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(53546011)(66946007)(8936002)(33716001)(508600001)(38100700002)(5660300002)(44832011)(6486002)(66476007)(316002)(86362001)(83380400001)(26005)(9686003)(2906002)(186003)(6506007)(6512007)(6666004)(66556008)(4326008)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0pqoytimKRbBhII4JM8yKKbCfSeVu1JwJ+MAmucI2renP7TCa55sNHt24N?=
 =?iso-8859-1?Q?r6d9AoGeuD2F38p6QWaereogDoUTorMVrWdYGVdmKrroTyVLnfS4YD6Jja?=
 =?iso-8859-1?Q?SVIyGv4BInzIg2Cjc+lhKculr8mEi7LSZho6U5JE2dnTGPiOFK1/Nq32Gl?=
 =?iso-8859-1?Q?AVe8LynhWKKPEESrIxgH46cVgim0rXPHMWHyFCT9GDL8VeDskYICtBk5MP?=
 =?iso-8859-1?Q?p/NcAqVk0sECiM49dcY4HqNtMEOkwB9sglVXsd27O5ERU3GqkaguqBXcg+?=
 =?iso-8859-1?Q?yiKxJpv4altV9yFKTYZ7Y3StV/xto7YP6m548AGRv1VxV9umjtW5o2cmUI?=
 =?iso-8859-1?Q?3Bs5YYp0zAN4FeFQ3ebzq7+DDlaTNBJv/I51XGkuPExRjLlEBTdUmP0M4K?=
 =?iso-8859-1?Q?6f9a/aplGZkeuK5fVD8mkWPpXSC6X12c2P/pTXNmw2ULlJzobjPIIoumOf?=
 =?iso-8859-1?Q?KdytLqp/KseMWMDT6cMtWfe986muLAAtQXJrjW8BH8pchwwKatYzxkLW7V?=
 =?iso-8859-1?Q?JI6n8MxaxfXYCmML/2XpGznFgyPK2hWcW42U+cxgx9OgUo3hazCm7jN5Zk?=
 =?iso-8859-1?Q?bGEnfjmf7faCTzL32OzbbnfnhYjbO+9P/soKa5IJnr1g77YEYzpK9Ljkap?=
 =?iso-8859-1?Q?H3aIFxWeKDmL3ZcJhubeij+70hflzcZ+zsl2gOyn455yLsjZHcdr5uSGYP?=
 =?iso-8859-1?Q?zyZAdI2jM/BSojPsg2iPd9Nd5VZT/eHXbNxrxO16gDmaGvWozcXoZroqIX?=
 =?iso-8859-1?Q?CC4cQE6ClhVkw6b/ObnhUKgpya0pAigVJ0uB06JuisnsvMdb+RGFLcqK8S?=
 =?iso-8859-1?Q?glv3/uXPDSMAIbgPGnzNpQ5eebOWNoZpFUKhnxKc4e1obLMbr5P55KYg7O?=
 =?iso-8859-1?Q?Yf7qce0XGnUbpndwxErCX9pkjiudturAQ0clnF6avWpzweNGehstqsN0yq?=
 =?iso-8859-1?Q?WFqVmjHeseSCz7k9/dkNFWHeL+ac8pj8HRVRnE1H6TNtPP/R07oMPdIOYu?=
 =?iso-8859-1?Q?R9NdmEIYEQ5M27lpDmgZ2nJ1ZIDcGgbCmk6YQ5nJPwE+Hcwenq+FM2heFm?=
 =?iso-8859-1?Q?Y9o3WSiZMxTpBrHN4hs+RSGOdEO7jZW7eurjSIZpCddqVjEUaKKKh6fPwS?=
 =?iso-8859-1?Q?bWqKpT4Tt0RdWCa140TjsXzrix2aYU/QXicQhX1XgVS1BDE59tdfgXmKR9?=
 =?iso-8859-1?Q?kq1m18PWlFG9dIXJjPcQS/4/LDXtPrD3s+7vCbHC67VgUb6NXu3Dv+z4bE?=
 =?iso-8859-1?Q?zRyc0ERXMY6hJYXsKtyjiBB1rrODJueqm6IkWtqpdeiH1jWuiW/dKV/x+Q?=
 =?iso-8859-1?Q?AQCQcz6BzbfBGIUeTRRnZj5tVjv+zYDCEi4TODXVKvnQYsz7WqNwIzs1dk?=
 =?iso-8859-1?Q?4jUs8SgwBEu6xiFTbSv5AY3UcPr0eDi2fsaign8U1D/n/2ax/UhgIdjdcM?=
 =?iso-8859-1?Q?e9o23SMtBgr4el3eBty95TmW1A/IuRkMHCBY4XRVoMa/VmoNss8YUkBjoi?=
 =?iso-8859-1?Q?/uIRX+zeo8wEIU/C47doOpR3lUjjCcJ9dKIfsrgpR+efNpaVTM7sl6cvf3?=
 =?iso-8859-1?Q?fRVL7Aw+UiDpRNMQ32Go6Jz9vZ9fBWZKtRKom5lka3u3TKP/Ag7Er75ffx?=
 =?iso-8859-1?Q?Cu4CgkWcsH4OhDKt1I+GghpreCrWBMxFD1C441nhdsxZRvCx6IMeDpAcEc?=
 =?iso-8859-1?Q?PmVcatHu/qESGa4Hf90=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2531ac-c288-48da-23ac-08d9e7f62e50
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 15:51:17.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ir4IPPhZq7dLv787GZLLss5lvYqc014K1BFehp1FLpd8aWY9wE7C9cEji0NQAl+fztx7RtTeV4YGJVJra8knDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 03, 2022 at 04:46:44PM +0100, William Roche wrote:
> On 03/02/2022 15:09, Borislav Petkov wrote:
> 
> > On Thu, Feb 03, 2022 at 02:19:19PM +0100, William Roche wrote:
> > > As we are moving the dram_type cached date from pvt to umc for family >=
> > > 0x17, should we also add a small comment for the dram_type field in the
> > > amd64_pvt structure to indicate that ?
> > Who would be that comment for? People who are looking at the code, so
> > that they know which is which?
> 
> Yes, it could be a hint about the use case of this field.
> Of course we could be more complete and also comment the umc field use in
> this same structure that depends on the family higher or lower than 17 too.
> But I had the impression that the creation of a new dram_type cache field
> would be clarified by a comment on the old location, that's it.
> It's up to Yazen and you to include or not  this small addition about
> dram_type.
>

Thanks William for the review.

I think this is a good suggestion. I think it could be a bit more verbose.
Please see below.

Thanks,
Yazen

---
 
From 028207619fb01008a2defc65183cbd30f98c021f Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 4 Feb 2022 15:10:52 +0000
Subject: [PATCH] EDAC/amd64: Comment on which dram_type to use

A copy of enum mem_type was added to struct amd64_umc so that memory
type can be properly identified on each independent Unified Memory
Controller.

Add a comment to the original struct amd64_pvt variable to indicate it
shouldn't be used on newer systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 6f8147abfa71..38e5ad95d010 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -397,7 +397,12 @@ struct amd64_pvt {
 	/* place to store error injection parameters prior to issue */
 	struct error_injection injection;
 
-	/* cache the dram_type */
+	/*
+	 * cache the dram_type
+	 *
+	 * NOTE: Don't use this for Family 17h and later.
+	 *	 Use dram_type in struct amd64_umc instead.
+	 */
 	enum mem_type dram_type;
 
 	struct amd64_umc *umc;	/* UMC registers */
-- 
2.25.1

