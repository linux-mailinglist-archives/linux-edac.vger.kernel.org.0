Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9965618C1FB
	for <lists+linux-edac@lfdr.de>; Thu, 19 Mar 2020 21:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCSU6W (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Mar 2020 16:58:22 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:60353
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbgCSU6W (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Mar 2020 16:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Noq7FvBbgaOaSqvwA1iheGUDksTkpXNzGV7Y2cUYEK32/SbJrOiB9dB4IKqGlZfWfiMn5brhclSjO3YqHy32GV/B814U/4bDsILcv+yWl6T1CnvtLkXD1B5KHilleeJBr5NWzd9fCbj8IMenyTUiRoSqRMMCdQ3WTY5/YPdeE9cRJGEXqh09omQ2xa2+SS08xMXKN85s85UzdOFXKjDJ/h2VRKeBP2CQXJ/JbvvlWocBQTAPSwDYABOhuTxb6p8eCUUnpwzQvva+TZka6kiDUoY7H4VOpiYep81YqcFlHKI9a5wrklSay/9LbsbioUYumxXWnbg567WdOBkeBRv+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r87MK6WsDezsBN7w6/iMyggyubbKIqwEVoKT0dzEBw=;
 b=M6o7oc0AoWF/PFCnp4hjn1LoPnrBZYA8efwfFY9E5cKkx2HrxNXoPN/Facg7WXZzIJOOgR4YR9a1O+vMZGHO/V/1biiePVmXX4J0D4ja4leWNadh591UMux20yfXATMwzt+jaAERE7w15YRF72Sk92BI71J9oUok04Sh9VCfq3BR4rpxsP52TpKlyckFGxS44GEHt4KiMtzh+AAvDv5Q1RFLss52umqDUxvzb7uCJw0vpw8u/gESjDAfezgNjBfddwIqu2fFEsB/5YQfI1OfkYiwdEuFFBLKx+mNh1C9qIqpWr0lu1cSVzElXS13FRGk3+qkaygJ9lQa1gTPXc/VjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r87MK6WsDezsBN7w6/iMyggyubbKIqwEVoKT0dzEBw=;
 b=w6KVmubkAJu8Ix+1u/bAWP77e+4Jf+lFlgG7LECRzBcHZM98J5JQ27GPhSRagkMKO8StKqgRU1K85C/2FZVzTxgc/JcWTom8dyHRFhwWW71QHd+xAqfFzkBKn7lrwKQ8eKpy1NWgUuW+cSpSGDmqtjo2R/YxAOa7KT0ljwYY0q0=
Received: from CY4PR12MB1352.namprd12.prod.outlook.com (2603:10b6:903:3a::13)
 by CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Thu, 19 Mar
 2020 20:58:18 +0000
Received: from CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8]) by CY4PR12MB1352.namprd12.prod.outlook.com
 ([fe80::5cdb:285d:f962:c2a8%12]) with mapi id 15.20.2814.021; Thu, 19 Mar
 2020 20:58:17 +0000
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
Thread-Index: AQHV91+4T7XLGb2nU0+KbGhK1YZA8KhLjQqAgATaUICAAAHeAIAABltZ
Date:   Thu, 19 Mar 2020 20:58:17 +0000
Message-ID: <CY4PR12MB1352F7AED37C67DAECC063E6CFF40@CY4PR12MB1352.namprd12.prod.outlook.com>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
 <20200316180829.GP26126@zn.tnic>
 <53d25b8c-dabe-1b91-4d3b-0a223075e42a@amd.com>,<20200319202134.GG13073@zn.tnic>
In-Reply-To: <20200319202134.GG13073@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-19T20:58:16.718Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wei.Huang2@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12c29e47-395e-4b1e-4d9e-08d7cc483fb4
x-ms-traffictypediagnostic: CY4PR12MB1943:|CY4PR12MB1943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1943913E99AAD4FC5C904C9FCFF40@CY4PR12MB1943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(199004)(5660300002)(86362001)(33656002)(71200400001)(8936002)(54906003)(81156014)(81166006)(186003)(8676002)(6506007)(7696005)(26005)(4744005)(478600001)(66556008)(6916009)(66476007)(66946007)(55016002)(9686003)(66446008)(64756008)(316002)(4326008)(2906002)(76116006)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1943;H:CY4PR12MB1352.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gx006kP7hk0nLRE5I2jogTggweR3rmSA4wInrksAANxCnLLP2tsHzxi9MsK1eN3pPQU2tRItbIsoheRw4OQ3jAFhY9bBUntDSGxgpgNYP6rOqjn9TRUv4nFUdJYNTjp1qt9jnkAd+K7E7LF/tZxJ23s/ohZV8uAjxxsu0YbeX0VVfjWlHMMZG6Gu0qcZ9fk77EyTy2/d41tqNHeYYRPB18xiKucBWd8dNQ/GXFWr4e5sCaM857YNn12XqJ+HIWbSxFJbKRQAqn5nZ+JVGCnJQYoLRIkmWsVDyfwFQxUQDkjlEHMavx5r9x4usdAF4OJA4UWG3Hvv0hI6bpXiakU9qZZWmdfVjBQHS+m2TydG4V7zI2NAziim/I474L4lbW2Ol0RCzArKBIAxsnFAcfQHKRMifz1HATcvOY/pUQLm7gLh0kB8lTNI2aO46nx74BYa
x-ms-exchange-antispam-messagedata: WmCX70houRBw7MPd8FHE9VCy4e1hPMO9fcBJLtj3FzSXDDdsyHNvXkqgXdQUcYw0AZuN+kAtFj36eZzHh9lYCJuef3+zx+XAhSpCOcFu0J9EBhbEOxj2htamfiYY0QDVmLrewZ7zBcLaMZFHLZ5dsA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c29e47-395e-4b1e-4d9e-08d7cc483fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 20:58:17.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6aLW++ComFLizv+VNL2siJ6NIzcPxM13Hgk7zCV7vt6xM57QYWfUc7nuKW1Vg+e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.or=
g> on behalf of Borislav Petkov <bp@alien8.de>

Sent: Thursday, March 19, 2020 3:21 PM

> You can add it to arch/x86/kernel/cpu/mce/amd.c just like
> intel_ppin_init() is respectively in .../mce/intel.c, as mce/ is where
> this thing is used only. We can move it to kernel/cpu/ later if it turns
> out that it is needed for something else.

To use this approach, I have to clear X86_FEATURE_AMD_PPIN if MSR_AMD_PPIN_=
CTL is locked and disabled.

However, there is a small problem: during boot, mce_setup() is called once =
before mce_amd_ppin_init() is invoked. As a result, mce_setup() might read =
X86_FEATURE_AMD_PPIN incorrectly. This concerns me.

Thanks,
-Wei
