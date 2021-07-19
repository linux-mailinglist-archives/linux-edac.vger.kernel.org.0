Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1DE3CEF77
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jul 2021 00:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242370AbhGSWOz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Jul 2021 18:14:55 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:63968
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1385136AbhGSSsC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Jul 2021 14:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWLxLhxo5ol2FCncSUu1kvKac3KgTRIA4UKaB86Q4Hb3UcHm+MTUVwJhTG5faNkvU7QOwHt4suUbaZjcC+pJmQubSll5ZU+rhdERvcnYpl5xC037ji9kxQ4nkVEq8MbBtsuChb/ksNxK3sEOrnqMwfimiW5KXgCzBJ3h1Cfz5SSk9CCQ9g5eRJOQODsMuI1umCXJfQYQv3XrHeYRyM5Q3Fm7Qy+QJObvCZ3/ajTG/5RnqRgbU+2JdM+aMIfR3LuL4dFuX57Ld8tYAWq/r31xx0J5nFWQenjOhvVLNu73eF9O1uKDsxPr2pEe42rPsQ6bpjt6ZJDQ7mlzQC3jPLWEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKbM0f2btpT4tVl53+DQmBArurXPJa9/Aya+Ca0QUxo=;
 b=MU7OXeg9q6tS2JRVFFSWwKOcKI6YCRlIH6ObQunGWvPs//QMZiYsW1rgLXioQqyEA7OcGM39QMI9NJa8nygLEDJ1aHAOaNdK9hgH6KBp3efLRHfqPtJWrMscaYPQYczrFaM56vJKVofN4lHX4iAqmyNjX8toD6TbVFDJC0TiJkoEyROUeFsTPNAzbPSweonNYdQJfEQKD8RQhfX4r5rAtfu/1sy1zP2CS1QK0KEmQHbNTXf7BokAAkS+4LEqHHuZd9gYH9Uc0GOCE/7RkEUGNrG5/Da+VxbtWYLnY3I4rKrTYO/ixVsuSh432EVlyuUWR7VTW8K5PI8YJDu3LA++jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKbM0f2btpT4tVl53+DQmBArurXPJa9/Aya+Ca0QUxo=;
 b=dkuINDiB2201n0CctjQOaN/8XXUrZ8HhymMY1ZYPsWZOjcai1PjX7uELFxch7CoSNd8P5kjPkwn7p2QwE836UcQeXZ+OFt9AFGvyP69WnJnFWNpXu4rUij1NfLLc5NFl3nDN1uF0vZK8XYDU7uBp0wLJ3ox8DDVugLwDUsym2cE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 19:28:38 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 19:28:38 +0000
Date:   Mon, 19 Jul 2021 15:28:30 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: Re: [PATCH 1/7] x86/amd_nb: Add Aldebaran device to PCI IDs
Message-ID: <20210719192830.GA19451@aus-x-yghannam.amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-2-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630152828.162659-2-nchatrad@amd.com>
X-ClientProxiedBy: BN0PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:408:ea::17) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:408:ea::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 19:28:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e94d583-9493-445b-ec6e-08d94aeb685b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17487807F8C0EFB0D661562FF8E19@BN6PR12MB1748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WaSHuFOGcRQsVkULP95GgsXxKWFZnlLHFKIx3ReARUFEDAzUaAF/ghpQHcZ4crzxlFdjAo/Dij5L5cG1KZhcIS6LWXclbMk5to98DRiiy7AfjQCdP/2SnkGeMdV1l2LNKHVzHOND6sz2eMwatuWzvm4lnBizqE/9Vv6YNlGF1uCFl2lo5llwl9Y/ZGiJMeXEfZa+e7xEHUtXyTtZP9tiO/p1SVETAxoz6i2BZQNuEZ8/oaqyZuEOG4u6my5glimVAeC0cr6pzFOlMitjfkKSWK1z60MtNixJjTyuOZ1aIr4epDg215rkjoARDtkOo8uxCs47eVQQAGw91mfmmkbi/BtjEa9zkjDl5DWbY5r7Wzd80QPfwF6pCJjBMwJdd7sV9rIscNKhCffq0QEoePZpeNdzfIshVMoeGXPkD1e0X4Qe/hb9vMpd+WkvX9yA+6fR29YfOEPFJQ8BxGgX1d8H9QhQlausRSIWAurDwiXopWRawq0n7HSgpSBFa44ZLR9GuwkehfxgmRqQxe+3CUlv6gerYudConF2yr3SHi82Ae5N+mD39nu9jt6aQfcp7cHn2E/W+BC1V/2rmTrq609i5cVSfPV1nC8FQb/EPtITAyQ1qKzZtvmvI7fuW65/wdIQL6JXYq9YrJaWmwYaFmBTxqOay44t1O9sD0akdvArYywFfubG7F4BHokWRfHkUCKlyFKrSmjrj60CppWFIFU0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(6862004)(478600001)(86362001)(186003)(4326008)(44832011)(38350700002)(1076003)(316002)(6636002)(38100700002)(8936002)(8676002)(55016002)(2906002)(7696005)(6666004)(5660300002)(52116002)(26005)(33656002)(66946007)(66556008)(66476007)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZkkJMcbLzuR5ysRc3mchDVtp+02wBzGdZeWRWtvv+SnYtM/+urUgaq+gaaOS?=
 =?us-ascii?Q?XRsegKCdbgSSSPLRb3WrUXmea6b7DL91A8SwL5t6qi8j13BsVxPkLavcNqmU?=
 =?us-ascii?Q?NnN8jaJj6PBCh9MLAgwYGzklII4B/mpkGgWxz2nfum+51ciu7CU56V5EVQ6n?=
 =?us-ascii?Q?BYtLzhOSkFUePDNjM77EV/y38Rs623X+f2HnY8k39qKb5dk0Xclr71PArPpB?=
 =?us-ascii?Q?/xvu+UFcpYjq2VWSAUzRDbOvkacw5LzREr2HETDorl+VC9caE9qahkrcJva7?=
 =?us-ascii?Q?10l4XtjJi7t9kMBW6XJBZwEFbYYbwHINFjvYclR2zmsazAPCrj0+wLdYDwbf?=
 =?us-ascii?Q?7nFELW/FD2ARe/0RMPiCjjvLc/3lafpN8nzXJdNZo0EBZmKGWU4TnT19C46G?=
 =?us-ascii?Q?WbTxDPIeLtlNj/cSFHweHS9kl5Zc60Wn5Pa3cvbywYm7/LzH5Q3uyFXe84A1?=
 =?us-ascii?Q?0tts6FkhYeeGx6HGIBKpj0G+YORuaTStpOl7dAFNQCctqh92oIoZ9mLT0c3Z?=
 =?us-ascii?Q?lCakNGMlJSOv7oRlSQjLiPDl4KYQcL0YX04rNepD1Bykk/05vNMN2w/2YWOU?=
 =?us-ascii?Q?pOPf3BTVZ8M61pPOXRaScQ5GFBJt6j9PH3FT77/JlOLQKd+O7D+Jjr7fhejH?=
 =?us-ascii?Q?HwbD01JGylFtaxl17NzWn/t51mWMUcBa++jjW5qrMtPiA/GP0RGIonZry+eg?=
 =?us-ascii?Q?ZHqXiFjYnLmuUnc3GFYYNQU6qkMgi2ayMZOSfGa8Q8PFZjipU0hRllXnSAfC?=
 =?us-ascii?Q?WbwYRVJx7TfOlt3Kkqb3U3viIwwavJBAA+1wfHODnbUfqmk2zOXzzNGHANK1?=
 =?us-ascii?Q?F6fddcSFZgQiyGARYRCiLyMbN6X47GU99WxSi2Tc2CrulRG+CZn7bj9XQkjI?=
 =?us-ascii?Q?vo0FDO/afOGlCmi3OsQhkNsecPeKNwr+72gIQVXVLgv04DttZBGnrZ3/iepz?=
 =?us-ascii?Q?x6Tmc3UsiICDoQXBXtT2qWPu4D71fS1REVibPbfB+QOZZQqalRnQM5tVw4HZ?=
 =?us-ascii?Q?Uhnf8tVhTWlgQPSCZQJm3NhtCjXwMLKY6EdTizwEJBKaXapHvgDOYuVznBQj?=
 =?us-ascii?Q?4m5ry1o/JOlcCpmdESdItFLwrJ4DLigfOQFgOKSUiLMx4oSuSOelBsTz3f2V?=
 =?us-ascii?Q?sebtieudiSTLjk0mav2fj+OkEN7G2V3pepv6GmuAUrnf9H7BYcHMsb3oRrkx?=
 =?us-ascii?Q?uPzSuRxsKRNNg94zK8hjMCk8DQYjyl8TTpAeESonw5Q45VPpZq1Bp/WKi+of?=
 =?us-ascii?Q?O+6f8UIZ8tuZ2SYW813gnWUh/P40csuirWqIOCiBujRdWQcTh/lDo4n3fuip?=
 =?us-ascii?Q?TSA9dS7Gyvjps9KYyicMluHd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e94d583-9493-445b-ec6e-08d94aeb685b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 19:28:38.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/m2cwzHLTLrQ/KIUJZJQM/+YdG9TUHcVUg1II133ctvb9Es+XoW4Aih6+pz/zieEftWp3vD9Cou+hOheNzrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 08:58:22PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add Aldebaran device to the PCI ID database. Since this device has a
> configurable PCIe endpoint, it could be used with different drivers.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4bac1831de80..d9aae90dfce9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -554,6 +554,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
> -- 

The PCI ID looks right.

But I think this patch can be part of the next patch where this value is
first used.

Thanks,
Yazen
