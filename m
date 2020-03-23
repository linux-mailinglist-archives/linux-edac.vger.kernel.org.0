Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF44B18F6A3
	for <lists+linux-edac@lfdr.de>; Mon, 23 Mar 2020 15:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgCWOPf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Mar 2020 10:15:35 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:29906
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728407AbgCWOPe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Mar 2020 10:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhzNvc/S7DugXYndZs+KSKxg8qqnTaB6ZBKHqke96jOvsZDV+Ms165/SU2fPNuqx45n3tbTw1kHuWC22oTg1FBJeQVEtLmDwp9nh+a2sRxCP3XkUw2vVHYuLf7/gt1bb/drhHHLRfnExmLmTu42PUtpDahBCJu02wjLRYd7qupeHCWzJD7qPeVATaXdwuoF70JdWqmrHSmZFEdypVOivkRKVUGzhYT++I4Gl3r/jiRMiefrN3AAQSJjfyvzk0DvslXbOwydH1ZZmjSzQP6IqEoh2mhSY6HzlYcCO/Tkzvl/nJrdkU0Fg02NVJmMKRoIg5/p32WF/qdc2tQVgEGJAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Dm/zY28ev1sbs6pCTma0U3Fxo314eAGEoynjSiYiQ=;
 b=FQM8ecFfZyvVzG8zsVfDwv1NSgtNPlTHaYyrC79RwTRwTkCGoYD9Ht+9tHFrXgKswluQ/M8N3As+q92QbrdWtLMr05G+jB99n9jzHQkDAZ9U8slweOtNVaftG4gYSdULo9hfoW+kGsVIfgI9xvHrNvKJcTNLWmrWOaGEAYmygqwlJBjbPqUeIuq8GcvCqHn+lBwcXlZv3omcV5rDGcj+LJ6svWcbDUGW6/8OhHDdSiiw3ti7eRU7uHadwTiDtWjqO/gAXjO6lFd0wEzplulUQmPJrTEZSPG+0iAsSJVlao8Ui5GSLUwvauV+IE1narE5rninEA8gds9XKrcqA8PzJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0Dm/zY28ev1sbs6pCTma0U3Fxo314eAGEoynjSiYiQ=;
 b=dnr/pZbfNl3aWhMisLPY20QPkUVxwqrcDgjniSMKXI1L1JHnk9k6WdVEnayk4AY+Bhze+deZ/cERniNOaLW+7srJZuDiRUQ1LNfzJdxuEFg4vP+q+YVNmg1mlDWaasBjZoOVWYkuzlWBnKoZPSkTQVis3FWuMQBAR4jt8Ceh5Zs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (2603:10b6:405:4::18)
 by BN6PR12MB1473.namprd12.prod.outlook.com (2603:10b6:405:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Mon, 23 Mar
 2020 14:15:29 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::c4a6:6db6:5c7:a26a]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::c4a6:6db6:5c7:a26a%9]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 14:15:29 +0000
Date:   Mon, 23 Mar 2020 09:15:21 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Maarten VdA <maarten.vda@outlook.com>
Cc:     Kevin =?utf-8?B?SHNpdWVoKOiWm+WuiOeak19BU1JvY2tSYWNrKQ==?= 
        <Kevin_Hsiueh@asrockrack.com>,
        Aaron6 =?utf-8?B?TCjmnpfli4Plu7dfQVNSb2NrUmFjayk=?= 
        <Aaron6_L@asrockrack.com>,
        "jfgaudreault@gmail.com" <jfgaudreault@gmail.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: ECC reporting using an AMD Ryzen 3900x and the Asrock Rack
 X470D4U2-2T
Message-ID: <20200323141521.GA47463@yaz-nikka.amd.com>
References: <AM5P194MB0100DBBDC2DB57014FE85D52E1FA0@AM5P194MB0100.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5P194MB0100DBBDC2DB57014FE85D52E1FA0@AM5P194MB0100.EURP194.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:5:134::23) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.12 via Frontend Transport; Mon, 23 Mar 2020 14:15:29 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eae55c1d-632e-4fbd-3f68-08d7cf34a434
X-MS-TrafficTypeDiagnostic: BN6PR12MB1473:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14731DD4192D4E9582453C84F8F00@BN6PR12MB1473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(86362001)(55016002)(6916009)(81166006)(81156014)(52116002)(558084003)(7696005)(8676002)(316002)(6666004)(26005)(8936002)(54906003)(44832011)(4326008)(33656002)(66946007)(956004)(1076003)(2906002)(5660300002)(186003)(16526019)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1473;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvCIBpc2/eYsX7XLa0sI4bUUx4TUU6Jby9CXm0F0g1XX1gGyLuNSNTRccZgcIw45DBDIT+1F588laViBR7x4dtYZGslg5MDt8/Ed/JG1qIV9hwUNqTDMnu1E2ZqL5UP/tzMptueEfqCJM8VEx5y/FtYOq60e6xrPvNwOLOxQmyndcBPIAMhkvzwex+ktZPaE5JmIGAZGqX/GrBlBwc6XWcJdgcI7+qa5ex3UuQ5AlGt5XNqGoe7N+ZmnMdrudztgXdJqsKri/wfBx3fL5ohK7pv+6hJcuQReoxnBS1nFcPRnwGuZyXLTg0XhysPQq+LmYz5fYDIMBNYHJTtTC0szHEQD5+IdpbseOkCI0FY3AFiiTCmoEj6EJWoqU9RYZqtqp+bDAeyJAWLGp/XLMW4SzaYl9ZN4mbQHxyFK4WSJnvtr9L+2SU1M0JYXLRlPfXyU
X-MS-Exchange-AntiSpam-MessageData: +KMfengLpbeUjK+252B38rKCeQvHepWkA9F/bQSHscUmovZ8XEVCkh5qXkdZHgeikNLgxUqiy+GX6YLM15aUZiZofNoYof3Cdv2FeR7iFKIzAEIULR8OhI9fcL4sCVg0zGzfKnZR6sLdJnDkVFPPyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae55c1d-632e-4fbd-3f68-08d7cf34a434
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 14:15:29.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOEO8WIg0u+6923VNz7cs14Tm/udAAzWzRbH8sK9Vv9VnP/5zTIcjisiv4Cl0p+G7nHv/awEX0GSv8hJlnBrWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1473
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Maarten,

I've forwarded your email, and someone from AMD will contact you.

Thanks!

-Yazen
