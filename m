Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED818C273
	for <lists+linux-edac@lfdr.de>; Thu, 19 Mar 2020 22:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCSVox (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Mar 2020 17:44:53 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:6240
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgCSVox (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Mar 2020 17:44:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P46WU3i+KlwIcpC4YAplfjkl4PuQMZf1hwwyafayuMw7qYHAIah/6NBjpYRQ46878r990ydG9NLzI5QE57aq8KkmEXtIL13SxGnOGBAqGl0PjHqvtg0lavnehKr78Kyuk9WfnLTHHLF/Ubhr0oN1RUcF24jkAi3vF1ejM3NHZK1nSFEaJAyX9MMXc4tC/YbWVzBGRLUAX2XNMjdJie+FSIqgymNzxvNCPZwx5mViakKcfU1z41mPJmmY1BZNbYdAGEQx0ewTx3KQcvfGAL1IjtlP8w16xwF4ALSZWwiaxSObJ2oo7sv66WsGrHWBdkO3KQXDTARCYnB/hr8ZIAwSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAALqzfbQRmEgy2WCCsoYSNpiWRt727vPCiU1jnO2ew=;
 b=EvqDCRerCcnbAJaAV9tkY/eYQJqA+Il5lDQUnnK8zCETFxki99MV8gbgrsw6nPgg+IHtE8ZmU3AmTZwGWJTqI9/l3qqGFYulwr6vwDvLzeU3ibVo6A5nlBnLfgS4WH/MuG5HtHLgBfIZQ+s3yQXQbt7J0IVVGgr8f42ET96vtjO8Vs3pPEpBv9he0dbiLfeh2XThcr9NcAc7GuF9ZJgpN15cmL2MzcUd5zYjaxy8Vve3f23Dz5mkdw7i605VZnivIt7+dV7dKt4H9g1pAqr169MHwUIOVVVd8jjhpNUTFImDkGIjSh8qP13+3e0N0SkuYkhdlahBZwKnQ9FDIhR/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAALqzfbQRmEgy2WCCsoYSNpiWRt727vPCiU1jnO2ew=;
 b=ROk97njRpDtCLXCwmF3T2nlUFcbyd2z8bPzU61YhMLVGKyGuZIQykV4DwpU05VCgbxXqIH3wsRxzCWaZ7tgcHp39tR61Z8Czoqq1vcKp470ZcMFCOxW65KKZp0ZeurT79piJkEycagNAiX3Pfbdh8P1kABvTQ1uX+Kek6nC8Bns=
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1224.namprd12.prod.outlook.com (2603:10b6:903:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Thu, 19 Mar
 2020 21:44:48 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8%12]) with mapi id 15.20.2814.021; Thu, 19 Mar
 2020 21:44:48 +0000
From:   "Huang2, Wei" <Wei.Huang2@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Koralahalli Channabasappa, Smita" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Thread-Topic: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Thread-Index: AQHV91+4T7XLGb2nU0+KbGhK1YZA8KhLjQqAgATaUICAAAHeAIAABltZgAAG8ICAAAf6og==
Date:   Thu, 19 Mar 2020 21:44:48 +0000
Message-ID: <CY4PR12MB1352B6348409EE4FE3D40086CFF40@CY4PR12MB1352.namprd12.prod.outlook.com>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
 <20200316180829.GP26126@zn.tnic>
 <53d25b8c-dabe-1b91-4d3b-0a223075e42a@amd.com>
 <20200319202134.GG13073@zn.tnic>
 <CY4PR12MB1352F7AED37C67DAECC063E6CFF40@CY4PR12MB1352.namprd12.prod.outlook.com>,<20200319210909.GH13073@zn.tnic>
In-Reply-To: <20200319210909.GH13073@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-19T21:44:47.330Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dee882c3-aa3d-4a83-487a-08d7cc4ebf18
x-ms-traffictypediagnostic: CY4PR12MB1224:|CY4PR12MB1224:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1224BC76E01AF309A2FE7AA5CFF40@CY4PR12MB1224.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(199004)(7696005)(71200400001)(6916009)(8676002)(6506007)(9686003)(55016002)(4326008)(5660300002)(81156014)(316002)(86362001)(81166006)(478600001)(52536014)(33656002)(186003)(54906003)(4744005)(64756008)(66556008)(66476007)(76116006)(66946007)(8936002)(26005)(2906002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1224;H:CY4PR12MB1352.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igyWtVrCDXAKu+Me18Y+gZ10V7K9y0HPZ+5mU5aUyKJHcjgYZmfVKzT0DmH4KDyd/6IeY2DLOWCm0k46sG1AuMeW/brKN7Got3O0sP+YPcmxBlhcKTDU8zBgJt0xU0hphjjYpNY7YnQVRESlpvg3AfXfeM6uwUHIjerZ5+CSsze+V0MlxHZFd1G34MetwvOEslUWwMjsnyumYl4jYmh8aQUoeYk7yy5kMZlSieQIsikyBHDbqBJoeeQgH9dmmrYcCdLprHdYOOSkaRbNTXRj2UKp/KQMVRqHSAVxnAEFhuUm24qAxngDGOWqqgU4jMVkGhcXZT5gi7+KOzWcN+xxeoXV1rZqsr10qMXmgTdzChOG9j/HwsbRk+i2HrXUMHwjbAsEFN05kv7YHSDO3cQMCqCnxFuj3vOC6n43I3YWjxqpfgv2U9011fFeS45MSMaV
x-ms-exchange-antispam-messagedata: vgCXitXDuoJUGf1xFDZGmVXSCN8qXMffQ855VmEm4zFqO9lFQjUQh3F8GbEVKZG6iaR65moTpzLdGfv11PxTvlw0ZSBByibBUDcdfdf+OH++JQxguab4PQU7OQ9GCahCi/lziRU+g2H/jvFkyWVEKg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee882c3-aa3d-4a83-487a-08d7cc4ebf18
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 21:44:48.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+lFTnip62/2PApqcGLChz1/bmqqF7UjXm7CBXiDugd7PwbbRxpbUcxTMfMxdk4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1224
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

>> However, there is a small problem: during boot, mce_setup() is called
>> once before mce_amd_ppin_init() is invoked.
>Which call site is that exactly?

It was from machine_check_poll() =3D=3D> mce_gather_info(), right around th=
e invoke of identify_cpu() inside arch/x86/kernel/cpu/common.c file.

-Wei

> --
> Regards/Gruss,
>
> Boris.


