Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D75882D3
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiHBTvC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 15:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHBTvA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 15:51:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC19B52FE4;
        Tue,  2 Aug 2022 12:50:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272JInMv004816;
        Tue, 2 Aug 2022 19:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wo+igL6dDjNt9F8MEXZ8/MNJ4tiFHLHqFyvGhjANYOo=;
 b=FwnE7+RqhXpF6tYoV5Za3oWJ8JtcIeAhHaos1MfmIDgeWZnauwDzTHIZ4bQTmtlQNOl0
 L3pL7AfEz5e0AdYiR+cw4Kf90akt/dSfu+bE1rR9LNuqZgr+IdtRxo3J/k6dHn5MD1oF
 km6yBbAlZ5WOoiGexwLw5qmDYejv4ttR3U0N3hJ09xZpPoxi3biEQM/r/mNuMi6gTieo
 rDUiyjh8nzPyRHd7bn95CGwAg/+gOBwLz9FYlNSlferN4J+fAI4QvLNursLiPC9lwlBu
 9Z/o2BLaQP27ONMIRC+n4AsKNezvfxAk/T2dGirv4IsRN7/A0QWuMyuMpHAx8claLNME bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s81h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 19:50:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272IH4ld002941;
        Tue, 2 Aug 2022 19:50:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32n625-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 19:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHoVroBGtIUexi67Ho2cuRLnUOnmoKWhBefsnrT9GiwqZA3NAMtqdeZ38rAXvcN3k4lrdKb/XyzwCB9ojwrtzYa8FUc5lia6RosgncramyQ3SkdUgL3ZPoC/pvX7yjXadcsf9GH02sVvXJTOnjxn6hS60dfvJ5ZubUNQo8T2sXpmX32tnyCKPb5Zbg2DXSGMth8fsupCAPweSJptBxmv97mYS/mSVyhlClSJDT/28tmf0Fko1hLvrxXUdheXTIXsO9dKQOwDAkQY9MdlEMJkLFJZqA7sTRS68ZyM64HpUkFhecE5zApoqG1gF90Sp7NUYdeanYXVcTHEKh1/V0aXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo+igL6dDjNt9F8MEXZ8/MNJ4tiFHLHqFyvGhjANYOo=;
 b=mLSzo3h2A1rdADRD13P5AK34w5ldu5kiMFwEy6SLhSCjSJXhXQ68Hn/hyspmH5A8j6jh8KsFCoFJHUgVyInMC7iR0K/cAcxNAOs0UrA/RLdyTItAthKpov6AgwFiyCc8Kg5bUzXX9njJjcuoRdNSwvItN3PWhZdNiRnm0ucG1wwZuI544bzSwS41ab/l5E1DNZ+RWgH5lkmDq5rpNNM6d6x1jT2MG3N+lr2Xs9DdVbuTPJsP4p2TwLu3wo+MRb8gGLCEgDH8fUzBXM2aTawoMt5BFw0Tz8rPSlvgrpuzu73Phb1a9/4KkfFkFln1DFljk7Gy0eFhuv0Qt4ay5J21NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo+igL6dDjNt9F8MEXZ8/MNJ4tiFHLHqFyvGhjANYOo=;
 b=vSb2tNLOaQFxTcZ7mCalgIrs8iF7q+YLS9IqWpYVTUPJO3OlKo469xy79nE1JUO81+B4J8++RCgGY7zzmijqqK7R+7XO5llExyvGLiiyMbq74ZnQQlDGAqZkZF7CpJf+fwSIJQw0G3EQt5IxB4Dg6Chw0LykEGsXpoATA+TH/lU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MWHPR1001MB2382.namprd10.prod.outlook.com (2603:10b6:301:2f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 19:50:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b03d:e02a:73c0:a112%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 19:50:15 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v6] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v6] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYpgO359T9tS2tTUqvW6Gkpzz2/K2bcd2AgACURoA=
Date:   Tue, 2 Aug 2022 19:50:15 +0000
Message-ID: <b4b7eb42-44d8-ccbe-d460-9811a971a655@oracle.com>
References: <20220802000614.3769714-1-jane.chu@oracle.com>
 <YukDlb9SsZ2UlX8o@gmail.com>
In-Reply-To: <YukDlb9SsZ2UlX8o@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2f79625-bbd0-4443-3dd2-08da74c038a6
x-ms-traffictypediagnostic: MWHPR1001MB2382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8uhO9oDhS2CjxylHMk8auciXN2m6gwcmhvFWDQcJ8U4Da1XvNJlDPzjORKaxV+DoowsG8yplv9X4MfrtOsut81fHgQPEeyykRLdFgCH89eYrFYblfa2+u0np4gAi3OwT8a4OYMZI2W0fbGb/0mT99I4r1m5rEVn7sqyhldx5Osom257qYhz3cJmfCobRVOqXxKOw/1P9Js2Scp9QotZgaz0jkG5B6td7D6dCgfddE9/Z9vcL+hVD1Sd6pVMmijgy6DVSyggfvkSKDd6cS9xYLI+S/ayveG2ljiRDB3RCZshIYvrlZci89dSB/PCTOPC5DFTCWMANsvR4DZy1LKnEW+rgjQmjK9XbstUGM0rIgoNEHe0eATSBqPfzUoUxR3bsPQGQvUbIcrookmZJr484uPW6OXuwYuiGsmQcexDft504pVZCHzFdTKaAFjz8NCd3WyYJOb2Du6CU9EfJQJYtiGclYFAUSlSLbWfE16DAyk6vmSFu5c+mCn4YOTDKiUu8Mrxifb8G5A5RdfN+2L3xRiYQAzJDWYfXgxX7u0/zoP9a5sEx/9VbP9BP5ki1CzZWo6WZ5VxKw3Jg6ZmLDPCSOW1neol0wLgVvqUPFlp8NET33QrHtQ14WP2AgVPQ2r+dFcNEI4syZZ02fmTl3N2+1tjaTu4slQBbOm254Lw75KqayAuB0AFaRaxBe0PW0YGlWGSE4lZ7/tB9ekbcQVWEjuWzhn8n7Ll6wK0gUFmbYxsViDljVyHOI6C3C5Ps2EY9uwCQ2hBeIsL2fuxGJJYuTL9X04GsIbo439CCOEUT5RMpSt1L+1cHkUsyUlZLRqtF1t4cPih6fkqjx8DtsgEvbiw/YiX97698XmU+wfSYRtk/zQPPHq4qsksGAM+X+UDY2YBZJe/WKu4G0eHER+K2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(366004)(136003)(54906003)(6916009)(316002)(53546011)(6506007)(31686004)(6512007)(41300700001)(26005)(36756003)(8936002)(186003)(7416002)(5660300002)(478600001)(38100700002)(66946007)(2906002)(122000001)(76116006)(8676002)(4326008)(966005)(66556008)(66476007)(66446008)(71200400001)(83380400001)(38070700005)(64756008)(86362001)(6486002)(2616005)(44832011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajF3WlpLeVM1a1VyajhXbzByeEMvNnNGNms3aUtkeDVYQlBwWWZMcWdrL3Ir?=
 =?utf-8?B?NzJHV3RLbzQ1TkZ5cHRPa0FoYzdxVSt0U2xRQjM0ckE5V1BmZzFHbktFOTgx?=
 =?utf-8?B?cm0zMCtGYUZGQnpCOVV3dGlrQlFpSU1kL1BpYnllUlNDU3FaTFJQWncwNkJ4?=
 =?utf-8?B?WkI2Y0FEUnZWZ2RrTHZiMTcxT0ZnV3AzRUdFYVhCQXVka2FzL1pHcmhBaXJz?=
 =?utf-8?B?RVVzWmJ3YTdSUmRURjV3WWpJMGdpME9ubllwVFdybG9CRDlNcDc1L1lpM2R0?=
 =?utf-8?B?S3BpTnM3NnJtM05TN1dSa2lkVVRUb2NWczg3TGZEMzZkeCs4dW5VUnoxVkc0?=
 =?utf-8?B?eHdWTVRraWFZejFUeEJrQmIxU2Y2WmdTOG83RGhMRXJmMnp5Umk0WmtMNC9Z?=
 =?utf-8?B?RjlvaXRtSVIxNTNzTGp2cFRhZ2hPZTlsWXRDMStpMDBGUmZQVjhJd2JYUFli?=
 =?utf-8?B?MVNpbUhvSlh3R2JYWkhkVEpTSDhwV2Y3UHdZdGxZZlZaU2E1QmhESng2K3l3?=
 =?utf-8?B?bnNRMTBURzBXSHFhQS80VGhKZUtlRGNvQmx6NUpQWHJLYnFFQWp1QjhJQlFB?=
 =?utf-8?B?RjNubkNtRGUwamlZNFBzTSs5RTN3emlwNmdFS24raWFPRTh6ZnJ2a2tpQjBt?=
 =?utf-8?B?MXF5K1p5SFRaQ040K3FZRFI5dXllcUxiS1BmaTE3QlR2UHM0NWwxY3h1S1RT?=
 =?utf-8?B?a2Y0em1ocDhTVDdhY3J0SnJ6cnpyNE41MjdCQmJmRGhlNjA2RloyYURjTDVl?=
 =?utf-8?B?aHFHak4vaTNwY0k0bGVCQ1hUd3pRT24yS0NzZUhSMWh0M29XSXBubHJ4cmFQ?=
 =?utf-8?B?VXQvZytmRFI1K2c1K0U0SFk3dkFJYkw1NmtFbEdnai9QN2VVT01XcnpvVHZx?=
 =?utf-8?B?YnNrTDlWV0VveWk4a0lYbDd4M1JrZ3JGeDJtaEE0K29Pc2FTdXZhWGo5cHBF?=
 =?utf-8?B?WDZ5ZUIzV1Q4VGoyVHJlUVh6N1Uvb2oyYnE2QUx0N29WVEtmL0FDajcyZmhw?=
 =?utf-8?B?VERSbVpmcDROY2NwNlp5cU5ueUNUVXRuK1Zyem1jUEZxSDVtWGlBTUNENzls?=
 =?utf-8?B?YWtVYUlpUW9UdCsrOEF6QXlRRWtUZ29jRTI4dkRYOTdORjZ3VTMxWEk2cC90?=
 =?utf-8?B?Z2hEUzVraUpNeTlWNDJQbFBmaE4xM1d3bmRPdHI3M29JUmxCRlFGMms3NVo0?=
 =?utf-8?B?YjZDL1BRTVI5VGRlNUZhRk9uTkpYNlhVREpDdTA1L0grb3BKR1NoU2JCdmZR?=
 =?utf-8?B?cy96R3NzOVZrTGRxZEFWbFl3S0FYR3lOVnVUaXlwQ1lwUjZmVGJrdU9CWGF4?=
 =?utf-8?B?UTNlSUJTSU13RWRnbUxmQ25KVzJhRnZBME5PUlNmRm9oM2E1Um00UlBsZm5L?=
 =?utf-8?B?Q24xOWlBdmhqNldzUHVMUGQ5YmtyYUVNZVJKRnhkSkorQ3Y4RFl3Z1U2U1Iz?=
 =?utf-8?B?R2lpT29zcWNkVnplWGIvZExrZVZNTXZCMk1ET3doc1JmM2NJUWJXZFJRLytL?=
 =?utf-8?B?dW93Y3ViRy9IQy8rNFBRMzIydjNXOUVGUE9ZcDVZRzZpM1N4bU5DZm01cEdr?=
 =?utf-8?B?Yzh5ZkExMUhFQnkrdk80dmlzQUhrODdxQkpUZ2psWVpUTjRhKzFOWit5Vm9P?=
 =?utf-8?B?WFdjTmRwRTBKS0VZTG5MNWhEMFY3Z1orZ2lhdDJxWHhKMnV6TmtPd2RyOWU0?=
 =?utf-8?B?QVNXT2prNEdKUGxyQytxSHNmU3NFb1c3elhtb0lwMFUzMTFuVTU0Z2ZSWURY?=
 =?utf-8?B?WC81UTQ2TC9yWEo2UmNEcCs5NmhYaTV3WHVZa3p1d3pIYWNWUi9FemN2MGxh?=
 =?utf-8?B?TjJOWGpQU050TEpQV05vTzRERVYzUHNYSkc1NGV1Wlo1VEExVy9RMWxPVG1M?=
 =?utf-8?B?MXZTZUlMNDkxTHJpWFlhL1d1UlRXajNRZmN3bTQzRG1pMXROdnkrNEQzRDdY?=
 =?utf-8?B?dmY4dVZReC9QT2dCU0dlZm5lZmpBV2pOK2tHMFUzdEtQcUk4YXlzUElKL1lh?=
 =?utf-8?B?RGwxY2szZWlub2pQMG9oa1JFaDNTZm9xVjFsUXZWczUvZmFJaXdRbTFyelU2?=
 =?utf-8?B?RjA4clNZNVd2VE9xd2MzWnkrZS9JRnlMaTNyY1dOOWJiSStTeVdPdFZ3OWtG?=
 =?utf-8?Q?SFfU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04362A00C9869A4D9BF3BFB97F0F3EA2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f79625-bbd0-4443-3dd2-08da74c038a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 19:50:15.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eL324gyQ30tS7d2zy7jXkdv+kLkFD6m6qFI7EAoZ5tStPml2MJIiWO3l5qqngzp/yUE2CozhVw54LXy6Mp9VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020093
X-Proofpoint-GUID: 89GswwuOnxZG1FH06w_8AOXWkOVsDtIB
X-Proofpoint-ORIG-GUID: 89GswwuOnxZG1FH06w_8AOXWkOVsDtIB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gOC8yLzIwMjIgMzo1OSBBTSwgSW5nbyBNb2xuYXIgd3JvdGU6DQo+IA0KPiAqIEphbmUgQ2h1
IDxqYW5lLmNodUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+PiBXaXRoIENvbW1pdCA3OTE3Zjlj
ZGI1MDMgKCJhY3BpL25maXQ6IHJlbHkgb24gbWNlLT5taXNjIHRvIGRldGVybWluZQ0KPj4gcG9p
c29uIGdyYW51bGFyaXR5IikgdGhhdCBjaGFuZ2VkIG5maXRfaGFuZGxlX21jZSgpIGNhbGxiYWNr
IHRvIHJlcG9ydA0KPj4gYmFkcmFuZ2UgYWNjb3JkaW5nIHRvIDFVTEwgPDwgTUNJX01JU0NfQURE
Ul9MU0IobWNlLT5taXNjKSwgaXQncyBiZWVuDQo+PiBkaXNjb3ZlcmVkIHRoYXQgdGhlIG1jZS0+
bWlzYyBMU0IgZmllbGQgaXMgMHgxMDAwIGJ5dGVzLCBoZW5jZSBpbmplY3RpbmcNCj4+IDIgYmFj
ay10by1iYWNrIHBvaXNvbnMgYW5kIHRoZSBkcml2ZXIgZW5kcyB1cCBsb2dnaW5nIDggYmFkYmxv
Y2tzLA0KPj4gYmVjYXVzZSAweDEwMDAgYnl0ZXMgaXMgOCA1MTItYnl0ZS4NCj4+DQo+PiBEYW4g
V2lsbGlhbXMgbm90aWNlZCB0aGF0IGFwZWlfbWNlX3JlcG9ydF9tZW1fZXJyb3IoKSBoYXJkY29k
ZQ0KPj4gdGhlIExTQiBmaWVsZCB0byBQQUdFX1NISUZUIGluc3RlYWQgb2YgY29uc3VsdGluZyB0
aGUgaW5wdXQNCj4+IHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyIHJlY29yZC4gIFNvIGNoYW5nZSB0
byByZWx5IG9uIGhhcmR3YXJlIHdoZW5ldmVyDQo+PiBzdXBwb3J0IGlzIGF2YWlsYWJsZS4NCj4+
DQo+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzdlZDUwZmQ4LTUyMWUtY2FkZS03
N2IxLTczOGI4YmZiODUwMkBvcmFjbGUuY29tDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IERhbiBXaWxs
aWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBD
aHUgPGphbmUuY2h1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvYXBlaS5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvYXBlaS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYXBlaS5j
DQo+PiBpbmRleCA3MTcxOTI5MTVmMjguLmUyNDM5Yzc4NzJiYSAxMDA2NDQNCj4+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2FwZWkuYw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvYXBlaS5jDQo+PiBAQCAtMjksMTUgKzI5LDI3IEBADQo+PiAgIHZvaWQgYXBlaV9tY2Vf
cmVwb3J0X21lbV9lcnJvcihpbnQgc2V2ZXJpdHksIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyICpt
ZW1fZXJyKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgbWNlIG07DQo+PiArCWludCBsc2I7DQo+PiAg
IA0KPj4gICAJaWYgKCEobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRzICYgQ1BFUl9NRU1fVkFMSURf
UEEpKQ0KPj4gICAJCXJldHVybjsNCj4+ICAgDQo+PiArCS8qDQo+PiArCSAqIEV2ZW4gaWYgdGhl
IC0+dmFsaWRhdGlvbl9iaXRzIGFyZSBzZXQgZm9yIGFkZHJlc3MgbWFzaywNCj4+ICsJICogdG8g
YmUgZXh0cmEgc2FmZSwgY2hlY2sgYW5kIHJlamVjdCBhbiBlcnJvciByYWRpdXMgJzAnLA0KPj4g
KwkgKiBhbmQgZmFsbGJhY2sgdG8gdGhlIGRlZmF1bHQgcGFnZSBzaXplLg0KPj4gKwkgKi8NCj4g
DQo+IHNwZWxpbmcgbml0Og0KPiANCj4gICAgcy9mYWxsYmFjay9mYWxsIGJhY2sNCj4gDQo+PiAr
CWlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9QQV9NQVNLKQ0K
Pj4gKwkJbHNiID0gZmluZF9maXJzdF9iaXQoKGNvbnN0IHVuc2lnbmVkIGxvbmcgKikNCj4+ICsJ
CQkmbWVtX2Vyci0+cGh5c2ljYWxfYWRkcl9tYXNrLCBQQUdFX1NISUZUKTsNCj4gDQo+IEkgdGhp
bmsgd2UgY2FuIHdyaXRlIHRoaXMgaW4gYSBzaG9ydGVyIGZvcm0gYW5kIGluIGEgc2luZ2xlIGxp
bmU6DQo+IA0KPiAJCWxzYiA9IGZpbmRfZmlyc3RfYml0KCh2b2lkICopJm1lbV9lcnItPnBoeXNp
Y2FsX2FkZHJfbWFzaywgUEFHRV9TSElGVCk7DQo+IA0KPiAoSWdub3JlIGNoZWNrcGF0Y2ggaWYg
aXQgd2FudHMgdG8gYnJlYWsgdGhlIGxpbmUuKQ0KPiANCj4gVW50ZXN0ZWQuDQo+IA0KPiBBc3N1
bWluZyBteSBzdWdnZXN0aW9uIGlzIGNvcnJlY3QgYW5kIHdpdGggdGhvc2UgYWRkcmVzc2VkOg0K
PiANCj4gICAgUmV2aWV3ZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KDQpU
aGFua3MhICBKdXN0IHRlc3RlZCB0aGUgY2hhbmdlLCB2NyBjb21pbmcgbmV4dC4NCg0KLWphbmUN
Cg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCUluZ28NCg0K
