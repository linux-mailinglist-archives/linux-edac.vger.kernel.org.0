Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAC6C729B
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCWVw3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 17:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCWVwS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 17:52:18 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837DE380;
        Thu, 23 Mar 2023 14:52:17 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLHeI1010373;
        Thu, 23 Mar 2023 21:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=tZVrkLX+YPjY1kgr85zbiVCP2xRVO4xbu+ipjqrHfg8=;
 b=PYhmodVqCTYUIaYEYfdo44wbfwVj8TC9zeRJxIkia5bfL9IqWEvVv0zuNI9z5SUV7f3k
 4IYuxzKO4EDYcd5p9vQm9RrRWjNbBkOQiubYptmD+KL13Omby3Ohk72XGdhXtFT0Th1w
 8JQSPZTWUQfyj77ROB7oosLzzpFy37jtfG0CRZ6nA6CszPXMA42z6l7Oywhg8NNqaIY3
 x83MYEuZB0uAQWfEftqxunj7phV8cpfgV8MZFeKR8hO71pif+8CJxjAdQyGQEUGseYoD
 2fMbBC0UwRO2EtKa6dtzVtDkQDr+rfkVTq8nolXBUpS4xXtY1addzEIOepKU3Idz2Kik QA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3pgxjc8h0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 21:52:06 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 98318130A4;
        Thu, 23 Mar 2023 21:52:05 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 23 Mar 2023 09:52:05 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Thu, 23 Mar 2023 09:52:05 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 23 Mar 2023 09:52:04 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpmE3Drd2tUz90CiNoVYg3MPLBp0Gf2feT+F/3+3rTdFb6LEU3ASoiZXUDChYG/rgFLgA2QtX6J+aTvDrzyQDdaJObizf64W5jvT8cIuViirBnwANSFfwaMPSs0RpKA1WmyhymgI4glbAvYJuOm6EPx3ZVPQD/BRCeoLS/XsLv8vZEwejBvLP1cZBFfH0GgPkdcnTK80aMuWW7HiqYX7AvoMLxx4Igk0bg6GrWufT0driD1LKzzOko6bcL5VJGEvDncfPbFgTy15ghqdZ80CBY1gMIzr5sNnA3GxVphnRZvCqOmRVP72cjuL6bd/xjIC4VvdJL6doqhgv43PTUOhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZVrkLX+YPjY1kgr85zbiVCP2xRVO4xbu+ipjqrHfg8=;
 b=gy65ABOY6TFEjy60aAz7Ue2tmnsnxL7Po8QcuKhrW/ht7eM4d/F40/evOnLeiVkt3fkszuTepa/MY48/29sFmLIJdcK2eCE7PCvGSuCKltcC0rul4fCaaMEM7o5TxIKfMx6OnF+wl7yXjWul1IZ0mWGO39QshQo1guRGa0a95oukk0mAoUEpT4Rg8B99wgboWjmSsTLbFu6dgO1GY6hROVSqmBjpmK8X8frzifrKrsgzI+5X+zm4I+oVbSxJ+dzS7vu+dKDBjovqYvGMRMg+E0qMQ8c10TMpJe+M2DKwjP0GvY1xG/xa80/04NTbNTs0QhRfmiIhthtMcAx4EL8s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::18)
 by PH7PR84MB1727.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:52:02 +0000
Received: from MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9a69:b314:be7d:878c]) by MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9a69:b314:be7d:878c%4]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 21:52:01 +0000
From:   "Meyer, Kyle" <kyle.meyer@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Thread-Topic: [PATCH] RAS/CEC: Move non-debug attributes out of debugfs
Thread-Index: AQHZXcWCn3lICQITf0aXTcezAqVcka8I0OMAgAAWtZU=
Date:   Thu, 23 Mar 2023 21:52:01 +0000
Message-ID: <MW5PR84MB171359C71BF003E287E2323C9B879@MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230323202158.37937-1-kyle.meyer@hpe.com>
 <7d9679e9-6d1a-bb08-dbcc-acb833bd5fd8@intel.com>
In-Reply-To: <7d9679e9-6d1a-bb08-dbcc-acb833bd5fd8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1713:EE_|PH7PR84MB1727:EE_
x-ms-office365-filtering-correlation-id: 42ec5b06-0afc-4db3-358d-08db2be8d595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOJibS4CEQ6sHg5HJRGCfyHiAnkzuDbYmXeVC2Bpb7cnA8uBJsaiq8VaGkr6Yqs/Jzupb08AZyrpXPJUzdsBnNejxQGM0RpMIzD/t87W2MrG4cVdXXbrVHAbj6dbAFKVbhMAl9eO4IfCcKdTI8BLNI9KqtRHgIvScxbiBdLry/5KhietO8I6FXtvGhKwHYC1KajZX+N9u0V73gNYy1AdcUrFkPLECtsDH2LM20WpcLomKtM/1cbxZx2oA96dDlNbMm5l0dmAUQlGAroE2wRU38eYwRmlGngS/oYJlWRZO2oqB3YSMGva/KIrbbekq0lBIZX1h/BgEmYxd22RCk2sb9/enAaMRtxneZplMWP8wB5COchBPyZRTIZJXipzKIGhUAIBB26vamtNYlk2L3cktPyrEOOCXuu+X20bE3A31L2rc9Nw4/070GrK+NWguJJowZYAndcjlzJUi+hANn9NPlwHVGvRf6zQvZTWY+QS8Ha6XVCUAPvGM1viNizbTQ3cob10ntkUb9W6xC4o7+ZZPg/n6+zsvnIxkk+FEHor2XED4EMPysvcI1gJ+tHupZhICb+rKy/B/WWKNYzyBrxCEDGxVVlRstYR0XPsJmjf5MBQLY8utFkt/vSdS1KQRpRqwTXLynhTTHR1jvJcbF+4OvZIO+EQ3zT2Ru4HmEFyNKnTRCY6hmBgc8V8tOpt76Pfm+KgnjLi94KXsNDXr3KsW3RP+MYCiUE9ReTF78hm7X0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199018)(86362001)(8676002)(82960400001)(38070700005)(921005)(33656002)(38100700002)(122000001)(7696005)(41300700001)(2906002)(66476007)(7416002)(5660300002)(4744005)(64756008)(66556008)(52536014)(66446008)(55016003)(8936002)(9686003)(186003)(83380400001)(6506007)(316002)(478600001)(26005)(66946007)(71200400001)(91956017)(76116006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g0/CtzxHREuMH1w4xbwNPp/qk1il/+taHPSpQCV7L5t/W00K/ObtINWypG?=
 =?iso-8859-1?Q?lInhEbHvU6oOUzj5wRigrdN/a2SLaiYbVyr2VfLTy/n5FyHXjC0CYFCzkY?=
 =?iso-8859-1?Q?1wtVvoi2N7/jegU6vdXU3qQ93pERU1eTKUAjTmo7m6xgXiCDHGEXS4kHwd?=
 =?iso-8859-1?Q?oL0guHsT9hfyRsgKz64wGylk4xpWrv/kI3OdcOO35UEZ3RWan9GpngFxri?=
 =?iso-8859-1?Q?F0Z0HzUOVyUFBUH7HaheDvfwUXuErSpvWJn9es4WXuJ2a7btwkHgHGHFvi?=
 =?iso-8859-1?Q?MpPFcqvAQHHlEjws/WfNG/5WHj3KtqzOfWpR9r42mLXXRKOliDfPuIE4DM?=
 =?iso-8859-1?Q?5CDsVzkhyPZrvlr9mpb7qURtA2pCglVApCA2R013esJirNw4w+NEA079bi?=
 =?iso-8859-1?Q?0l45sKxVlC3Qn+4arWCbyIneXs7B/fDYcKEdxgvvfTpqS6XniQXqylKxCs?=
 =?iso-8859-1?Q?T60gIsy5o5n/SRd+wf4bncZ316AMShMqpt5rV/+d1YC/3URHRRACCUe7gD?=
 =?iso-8859-1?Q?uH8ZTMiuXxNZN+4yTG7yLt997rswa1mF1dUEyPeuftyClBVnCh4VMzeIY9?=
 =?iso-8859-1?Q?59ptLiWsd0kvCHOtjr3lnmT+VOu/lNN2i/GIa5bj7sYm8iMVhiWwbNF6qJ?=
 =?iso-8859-1?Q?RRD+Lflu18oV0U8jz1uZTRWsdft3dXhZxNubKgWbf8MAtWR16Bj3OuL4wZ?=
 =?iso-8859-1?Q?5Xj73uskUjae1QeGmAHR2PoiqpgxHxANCWGE2FS8BJEt0JOtrs3C1xaSBA?=
 =?iso-8859-1?Q?qrQQSlcrEEF76bk+16FTmThYQDblbLPGXyIwBgaC6W9EuGtHn6cVeiNozU?=
 =?iso-8859-1?Q?Vh5ZlO755Kh3YK4SuSFSMoVHL6E8ZBO9wLdYVoGrJnYuU8UPf2OwBjOevD?=
 =?iso-8859-1?Q?htinL2EoexDb1k96aCiMai2sTZnjMsXscBQfADkM8tloXjfz7y50Mld1FR?=
 =?iso-8859-1?Q?fP0sFZpJnVoADtKUzyAphHQX3Lpr/llmmy8gtfyY/UhXc551CYH7oe5sge?=
 =?iso-8859-1?Q?36xg4dvuRycWUlHRSSK0wOHiBS67zGrGSjqCM/DOXzpVmPfThk5odDJQb9?=
 =?iso-8859-1?Q?Q1dngYxh9HVBQKlRntQ1r0z3IV6UJWRJaMrUftzNV5MLabhxGiStKrW08i?=
 =?iso-8859-1?Q?Ge8VqCae2OQtTC2ZeB7zmv+L0tDH7CzEhtxt6VRcZC93nCyugdYBMZYydj?=
 =?iso-8859-1?Q?oQH2JelyGjao3QcVdXqKmTyofnGPPC+CFStULed74pU8jTYOUGjRYc/n9T?=
 =?iso-8859-1?Q?yDlzSJtXyen6jn5o64oWNnSc0Ad2KEeYnJNTS6eEEwJn1fSusNtAN+4lDT?=
 =?iso-8859-1?Q?57+RR8MJa7Zs2vsokzE4h2otqTYWwI9hoXhO/IjL0wWuxjrvAsd13h8at5?=
 =?iso-8859-1?Q?jebkRrb5BNUHZPQ+gl/Vyqll7g/07m7QiBTeTBDIsih1lpJN6ZekAZbTLE?=
 =?iso-8859-1?Q?U3kdu03o1TrA+MOiNYSxwFc0gTLkok6ZL6g1Qrm6v3gQTlJWWxRO6mHHRR?=
 =?iso-8859-1?Q?VYilnHzDqva+3GnRmPxCtPsYDFqFdeyTel9S2fs+9cM2QfiBE09aX4wqpp?=
 =?iso-8859-1?Q?FacNhw9mzY4ac5ri3JuSBNwQhQFhA81SnJ0AGjE/sKk/8/Wft2J/po2ZV9?=
 =?iso-8859-1?Q?UX0v5tNoKps6wdnnogaETHshsdUEkryzKZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ec5b06-0afc-4db3-358d-08db2be8d595
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 21:52:01.8320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zi3T/i7gs84F3MBwka8QzK1llQpS8GE55GZgfdZq42jIh7ghSQw2J3TjKFVGbmZpFTDiw6xvbi+UWgAAf78hpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1727
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: AI1YWaa17VwpWIjdPfA7SILfcTENvTQ2
X-Proofpoint-ORIG-GUID: AI1YWaa17VwpWIjdPfA7SILfcTENvTQ2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=547 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303230158
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> You forgot to attach the patch that you wrote that updates=0A=
> Documentation/ABI/. ;)=0A=
=0A=
Thanks, I will include the documentation with a second version of the=0A=
patch.=0A=
=0A=
> Also, why *should* these be part of the stable sysfs ABI?  What app is=0A=
> using them?  Why does it need them?=0A=
=0A=
We have system scripts that adjust decay_interval and action_threshold.=0A=
They can't access those attributes when lockdown is enabled. If there is a=
=0A=
more appropriate place for those attributes, please let me know.=0A=
=0A=
> Why these two and only these two? What's left in debugfs?=0A=
=0A=
The other attributes (pfn and array) are used to test CEC. They are only=0A=
created when RAS_CEC_DEBUG is enabled. =0A=
=0A=
Thanks,=0A=
Kyle Meyer=
