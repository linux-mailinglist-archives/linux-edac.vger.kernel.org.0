Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32E63EAD
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2019 02:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGJAuj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 20:50:39 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:63959
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfGJAuj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Jul 2019 20:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkTsn+pSgj1a7EQpft2Z7awkvRruTaRO2U2EWqLzpst12leHdty4qPg3ICNTXNx8zzgLHDmcYCuXwiQVdZTtVQBij+99hiisPBBNkGRUaxJ4uw/HV6RkQaC9GMTFq3LS2/xU6sTy2xL7vykHicQkczCTB+FDsIzzglYZeQLlgBekZPjW84skTgOOrEPlEmi7xKTWzL4c1k+Uzt/6diyvVNxFQPB51LK56rCiVqHvdM0Nlxj46lbUBoUN3ZNhS/OcI5HUL/j9VHcEgqDpJEzI6q5mF1usIqwF9J0qP+E2llyFhTet7S5SpE/8ivgar7zX6hjOF9fW8Bc6pdCFu44YUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/MEdO4xKVJ/7QlENAs5nmXgKFkZBw/t9X5CO5f5ZqE=;
 b=U19wBf6pcLdRCyRCvQl7Uk7LJuVNnAfRy6xin9R1Xp5qfNHh+OVmOUeJwb7B0Z3NqVx8pqwwWIA3zIO70rKoXYQ7Gdk8Ae44CSAs+yvzB2ma6yf1BHDVTE9T78W5yQ4Z9IwVyI20V3yjk+sRm7mYz0gVa4eL2hnvlLn89nhOhfqtVTdcacK9PLKuSi852lCYvEVwL3OOjsQVwFbbZcfyPaTx9DEu1E9o3//iFjQrJQppdcwkCYZCnLkiaAODkjY2rqg2gZirHKQqykMc/Hcm821BRmmlkQFH+tTcCYutcv0ZxzDbbN+uDGsjzytgi/esF95/GftUXy7I7Plv2uaznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=os.amperecomputing.com;dmarc=pass action=none
 header.from=os.amperecomputing.com;dkim=pass
 header.d=os.amperecomputing.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/MEdO4xKVJ/7QlENAs5nmXgKFkZBw/t9X5CO5f5ZqE=;
 b=VeOxePKJuyAz88ECWJi5OkUm2UxW1qiQT6oKZq8iWisz+Y+ouOkFPSq26ZDxn0bh/ax77Vifm8swvczJM1qN867zzjdNg+M3wAuIrk5ZOxvqoXpnk6rJXp2evVJh/dQNbAFNi3e5UBPjxT6GDQAL8y9ma21OOr0MgV/G/2FGACg=
Received: from BYAPR01MB3975.prod.exchangelabs.com (52.135.201.14) by
 BYAPR01MB5335.prod.exchangelabs.com (20.179.61.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 00:49:56 +0000
Received: from BYAPR01MB3975.prod.exchangelabs.com
 ([fe80::a81b:f1e7:a31f:d464]) by BYAPR01MB3975.prod.exchangelabs.com
 ([fe80::a81b:f1e7:a31f:d464%6]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 00:49:56 +0000
From:   Tyler Baicar OS <baicar@os.amperecomputing.com>
To:     Shiju Jose <shiju.jose@huawei.com>,
        Open Source Submission <patches@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>,
        "Andrew.Murray@arm.com" <andrew.murray@arm.com>
Subject: Re: [PATCH RFC 1/4] ACPI/AEST: Initial AEST driver
Thread-Topic: [PATCH RFC 1/4] ACPI/AEST: Initial AEST driver
Thread-Index: AQHVMPZqphfhRm1STkOzQdqBSPqI3aa6dWVQgAibBEg=
Date:   Wed, 10 Jul 2019 00:49:56 +0000
Message-ID: <BYAPR01MB39758AB5AF4A67AF8278E361E3F00@BYAPR01MB3975.prod.exchangelabs.com>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-2-git-send-email-baicar@os.amperecomputing.com>,<86258A5CC0A3704780874CF6004BA8A6584514BF@lhreml523-mbs.china.huawei.com>
In-Reply-To: <86258A5CC0A3704780874CF6004BA8A6584514BF@lhreml523-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=baicar@os.amperecomputing.com; 
x-originating-ip: [107.15.51.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11b7165e-72d5-4b61-4309-08d704d08744
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR01MB5335;
x-ms-traffictypediagnostic: BYAPR01MB5335:
x-microsoft-antispam-prvs: <BYAPR01MB53356766A75F2327AD31CA2DE3F00@BYAPR01MB5335.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(189003)(199004)(71200400001)(64756008)(53546011)(110136005)(52536014)(66476007)(66446008)(7696005)(5660300002)(14454004)(99286004)(66946007)(71190400001)(68736007)(91956017)(186003)(66066001)(6506007)(2906002)(76176011)(76116006)(74316002)(66556008)(26005)(305945005)(102836004)(8676002)(86362001)(446003)(229853002)(55016002)(33656002)(478600001)(2201001)(256004)(11346002)(486006)(7736002)(2501003)(6436002)(9686003)(3846002)(6116002)(81166006)(7416002)(81156014)(53936002)(8936002)(25786009)(6246003)(316002)(476003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5335;H:BYAPR01MB3975.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NkfRPx5jW4m7iSKtG8mQFOGOt2LRr9M239mIYZjFCU8F+nRWpM6Hpz+HwVp83d5x/M4+7jvfPm0mXCOE/em7qCdDeYZ0dMlLtzDS5gqOGg8haeSVTnhhxBXsTRLsaYR7cXnaNwQdFv+G8jy1cEH/MfGx8Es10ZRpNCkXZeoEiUYJobAV+wFxbZufhp/PdkEiPn7hcXcMvJEXM71J9FUSu8F05+Ngh8+8pyya++5EKXr4kXW331rNK1Z9JoSC0vP05c6OroTzHCqhKiS+q+NFwGtQfNNaS/xGWxR60Cfd1xeUJBebWI5fgjU8IFvOnSr+tn1Ii0jAZPoAXZrb69RxJ+/HASpD9ovI3uZ50rIPe/25uEbYMPH39KEX9eQN4f0UWiMiAZchD+yy5FGN++V/NSVa1FwL616SlA7QELwMGRI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b7165e-72d5-4b61-4309-08d704d08744
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 00:49:56.3561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Baicar@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5335
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Shiju,

Thank you for the feedback!

On Thu, Jul 4, 2019 at 12:03 PM Shiju Jose <shiju.jose@huawei.com> wrote:
> >+struct ras_ext_regs {
> >+      u64 err_fr;
> >+      u64 err_ctlr;
> >+      u64 err_status;
> >+      u64 err_addr;
> >+      u64 err_misc0;
> >+      u64 err_misc1;
> >+      u64 err_misc2;
> >+      u64 err_misc3;
> err_misc2 and err_misc3 are not used. Are they for the future purpose?

Yes, these will be for future purpose once ARMv8.4 support is added. I'd li=
ke
to keep them in this structure define since that makes iterating through th=
e
memory mapped error records easier. Regardless of ARMv8.2 or ARMv8.4 suppor=
t,
each error record in memory mapped nodes are 64 bytes apart. Having these i=
n
the structure make the structure 64 bytes long making it possible for me to
increment through error records with the increment ++ operation.

If folks don't agree with that, I can change this structure to just have a
reserved field at the end such as:

+ u64 res0[2];

or

+ u8 res0[8];


> >+      ppi_data =3D kcalloc(num_ppi, sizeof(struct aest_node_data *),
> >+                         GFP_KERNEL);
> >+
> >+      for (i =3D 0; i < num_ppi; i++) {
> >+              ppi_data[i] =3D alloc_percpu(struct aest_node_data);
> >+              if (!ppi_data[i]) {
> >+                      ret =3D -ENOMEM;
> >+                      break;
> >+              }
> >+      }
> >+
> >+      if (ret) {
> >+              pr_err("Failed percpu allocation\n");
> >+              for (i =3D 0; i < num_ppi; i++)
> >+                      free_percpu(ppi_data[i]);
> I think 'ppi_data' to be freed here?

Yes it should be! I'll add that in the next version.

Thanks,
Tyler=
