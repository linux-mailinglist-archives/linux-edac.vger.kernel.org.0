Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643024C4F5
	for <lists+linux-edac@lfdr.de>; Thu, 20 Aug 2020 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHTSBP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 20 Aug 2020 14:01:15 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:60832
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTSBH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 20 Aug 2020 14:01:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFIlRNGRzbYQ0tesUBI96ybKC/mz7LNlZ+IK/Iek0nngb9+zNUGFF3J6EaPREaYLMcRuzprUvbAC9fbetCH4aEF18xF3uKBcLk0wvoz9tiXq8UKMwP+RSf7dTJIw11JmjI5LmN7Q7L1YzJRVtTjOY+DXMM8/awr42Zhxc98bHQsj9LFqmBXfh7kFWRJfU2K8tL8E+FqwMulmYtIMg6dSaCG9rjiMTNGUDmp+mDvvWurfvhYnXUldSmvnqF2pWeHOLJGhvJQMaemDnZGz8Rp+1Uw4cbrVfYJnz9mAgO4tA2Pwi7C0J8kVFspGEQO6stM/Xq3fJzdA8Pxnzx2eUoniYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+rzFh56q2WiWZVDG8MZ/H139OzzVy3W6fRNibN14UI=;
 b=g55FtQOzCicMYipyCsV3H6xLsvzV8EhOXczFut1dcA9oOeALHl30ud+DA8D/3xVpPzC1L5UGZD+QWR4rObO1R8fjkcRuObrN6fO0Lv935M0wb0C/5+Dfuut6A1nY5oC1YvCSX0laUSRjelAjdkHn64SHWhay5a6RL5B0XM40NAi7KNbLP2/yQ4POzZJPXSd82Z0AcqbA4Mhais8Hea5M8gtqWUnfTAQ3ef3+YDekCaK2MvRlVJgXBQOAXG5X4teyjn6dibPY6ivP5QA419rrlo7/gPmxtSMJKAoTT5njS6QIvFImvh2/XePkZMOXMSaTBI/oV3FrLspC/KH0awXd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+rzFh56q2WiWZVDG8MZ/H139OzzVy3W6fRNibN14UI=;
 b=irNCiNHGmPmdi1cg7iigAs5KrfyvC38ic2eZ7OGibxiW83w/bE8q4SqT1W8VBUrrOHXcVmwaPWvNMQyt+GGwJmWqmPJuzKT+EEm2UlqHj2u47eS4TJbw3FSXYD3IZtnV1Lwknu3uvyaFWWRHZI0U5A8Qi9BjAVB+SefCm6biecM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3170.namprd12.prod.outlook.com (2603:10b6:408:98::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:01:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.024; Thu, 20 Aug 2020
 18:01:02 +0000
Date:   Thu, 20 Aug 2020 13:00:54 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] x86/mce: Increase maximum number of banks to 64
Message-ID: <20200820180054.GA2033274@yaz-nikka.amd.com>
References: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
 <20200820171518.GB17271@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820171518.GB17271@zn.tnic>
X-ClientProxiedBy: DM6PR14CA0045.namprd14.prod.outlook.com
 (2603:10b6:5:18f::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM6PR14CA0045.namprd14.prod.outlook.com (2603:10b6:5:18f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 18:01:02 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0fa7616-3160-43d7-c256-08d845330083
X-MS-TrafficTypeDiagnostic: BN8PR12MB3170:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB31706953C71F387E577C1250F85A0@BN8PR12MB3170.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYI+VlnwvaySuq4A+04rr6bhIhm/+IBe/gU01ZpFxHSzYzrzd4X8UYAxHjybQK9e5cckHDg6HM7aHEAqq1lwx5TxsqkOF3ZAj6ObX8zg9/66qT3pLohrx4JhqBsAneo8IQF3lIPPVJXhQnosgsKmQp15wQDkC5bYSZ2sC5Wm+0dBMQhp28dKzg0NEgupacceHcyrUfy76JwefTwBWZToff5WeVu3GsgAf98zKLKtgU26oUMI4uBC1WWi9oTMIjqGRD4Do47rS+R+1Zd0pXjZScJxJknrYvV/y7suGzPHYScxHUctvm+LCVYcf4ztkwn5Zu9Z+vNfUVfTeOv9T0grDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(4326008)(6666004)(8676002)(186003)(16526019)(26005)(316002)(83380400001)(86362001)(2906002)(15650500001)(478600001)(7696005)(4744005)(44832011)(6916009)(5660300002)(8936002)(66476007)(66946007)(55016002)(66556008)(1076003)(33656002)(956004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5WCrbpzZTh2e+dEe+kD5ueqvZYpkQJfP2ZZiHXp/pfn/RDsQreTGF/nX9EbeeXu0rdtZO+29eWGJE3WrHz6N37qG8/aKHer1lAW2C6Vy4CfV2y/9UMW1n6c7UtvFb608f2yv3bKx9i3bwWRt1O68r7fuIp4I02rQHOFZqYwmNULG/h6CJpChp4ppnn9SpuE4knjky7yIcBLc2LktxFm9LAuCowSB4hPRe67vOFFKi2zi6wPiCBOd9pY84dToDMfargaYUcLpIO2rX5eNSvMyLF6KcG8nD1WRoCT7SkjE+8jy1Pgk+5DZa/qjJzQ7EzD7sU1BPV18BY7NCjkQnfyzg3pE7aFJvpVm+Ncg2R6TxjbLIegHYJHuthF94TgKBYNdKgexxddeuTEtakW3deq0o5QM/RlZhXGecdK/QUGB6BRJ0zAvL78u/zjyzgh4H4BKSA4La5UG1fvpiS42LyOKKMCuQR67BD+7CXnAF37B1LiQ+gHQuII/jHyJYd8cPEqTfm7JoHrL5Fdjki6DDnFoHxcnjjaPFDmVAwqY7/MpJF62bDaO2kIX5wgOQg+CBTMt+ClFQXjyOGVFSHvbR4LGkXsix2wDb3uq6pCbu5m1jq3KwBDeuT547qOOSvjyIhO0ob/q0mn2S5A3nnm+mXmnlA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa7616-3160-43d7-c256-08d845330083
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:01:02.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJYvy/I0z5dGXqr4qHruudnssZ2Kvu62uEUsbYsaCuz/I7wsGR3u0l87qqAtr83ahiSDvY39y2Efo7Wfl1IDrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3170
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 20, 2020 at 07:15:18PM +0200, Borislav Petkov wrote:
> On Thu, Aug 20, 2020 at 05:06:24PM +0000, Yazen Ghannam wrote:
> > From: Akshay Gupta <Akshay.Gupta@amd.com>
> > 
> > ...because future AMD systems will support up to 64 MCA banks per CPU.
> > 
> > MAX_NR_BANKS is used to allocate a number of data structures, and it is
> > used as a ceiling for values read from MCG_CAP[Count]. Therefore, this
> > change will have no functional effect on existing systems with 32 or
> > fewer MCA banks per CPU.
> 
> Of course it will, grep for MAX_NR_BANKS and look at all those bitmaps
> and arrays which get defined with MAX_NR_BANKS size. With your change,
> they will double in size.
> 
> How much does vmlinux size grow with your change?
>

It seems to get smaller.

-rwxrwxr-x   1 yghannam yghannam 807634088 Aug 20 17:51 vmlinux-32banks
-rwxrwxr-x   1 yghannam yghannam 807634072 Aug 20 17:50 vmlinux-64banks

Any ideas? Maybe there's some alignment change? Or a build issue on my
end?

Thanks,
Yazen
